class Acldog_dbGenerator < Rails::Generators::Base
	
	def create_initializer_file
		generate "model", "role nombre:string:uniq descripcion:string --force"
		generate "model", "user email:string:uniq password:string salt:string active:boolean role:references --force"
		generate "model", "acl action:string controller:string role:references --force"

		rake "db:migrate"
	end

end