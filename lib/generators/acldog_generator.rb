class AcldogGenerator < Rails::Generators::Base
	source_root File.expand_path("../../../", __FILE__)

	def create_initializer_file
		gem 'digest'
		gem 'mysql2'

		generate "model", "role nombre:string:uniq descripcion:string --force"
		generate "model", "user email:string:uniq password:string salt:string active:boolean role:references --force"
		generate "model", "acl action:string controller:string role:references --force"

		rake "db:migrate"

		directory "__acldog/", "app/"

		#list methods for autentication
	inject_into_file 'app/controllers/application_controller.rb', before: "end" do <<-'RUBY'
	before_filter :authenticate
	before_filter :permission

	include AclDog
	protect_from_forgery

	protected 
	# Returns the currently logged in user or nil if there isn't one
	def current_user
	  return unless session[:user_id]
	  @current_user ||= User.find_by_id(session[:user_id]) 
	end

	# Make current_user available in templates as a helper
	helper_method :current_user

	# Filter method to enforce a login requirement
	# Apply as a before_filter on any controller you want to protect
	def authenticate
	  logged_in? ? true : access_denied
	end

	# Predicate method to test for a logged in user    
	def logged_in?
	  current_user.is_a? User
	end

	def permission
	  has_permission? ? true : access_denied_no_permission
	end

	def has_permission?
	  is_allow(session[:rol_id],self.controller_name,self.action_name)
	end

	# Make logged_in? available in templates as a helper
	helper_method :logged_in?

	def access_denied_no_permission
	  redirect_to login_path, :notice => "Esta entrando en area restringida" and return false
	end

	def access_denied
	  redirect_to login_path, :notice => "Por favor, inicie sesión para continuar" and return false
	end
		RUBY
		end

	#new routes
	route 'get "/newuser" => "users#new", :as => "newuser"'
	route 'get "/login" => "sessions#new", :as => "login"'
	route 'post "/validate" => "sessions#create", :as => "validate"'
	route 'get "/logout" => "sessions#destroy", :as => "logout"'

	route 'resources :acls'

	route 'get "/users/new" => "users#new", :as => "new_user"'
	route 'post "/users/create" => "users#create", :as => "create_user"'
	route 'get "/users/edit" => "users#edit", :as => "edit_user"'
	route 'patch "/users/create" => "users#update", :as => "user"'

	route 'resources :roles'
	
	role_admin = Role.new(nombre: 'admin', descripcion: 'Administrator')
	role_admin.save
	role_user = Role.new(nombre: 'user', descripcion: 'User')
	role_user.save

	user = User.new(email: 'admin@admin.com', password: 'admin', role_id: role_admin.id, active: true)
	user.save

	acl = Acl.new(action: '[all]', controller: '[all]', role_id: role_admin.id)
	acl.save

	puts "User: admin@admin.com"
	puts "Password: admin"

	puts "type: rake routes, for see new routes."

	end
end