class Acldog_copyGenerator < Rails::Generators::Base
	source_root File.expand_path("../../../", __FILE__)

	def create_initializer_file
		directory "__acldog/", "app/"
	end

end