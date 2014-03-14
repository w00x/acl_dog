class Acldog_db_populateGenerator < Rails::Generators::Base
	
	def create_initializer_file
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
	end

end