module AclDog
	def is_allow(rol_id, controller = nil, action = nil)
		if controller and action
			match = Acl.find_by(role_id: rol_id, controller: controller, action: action);
			all_action = Acl.find_by(role_id: rol_id, controller: controller, action: '[all]')
			all_controller = Acl.find_by(role_id: rol_id, controller: '[all]', action: '[all]');
			
			if match or all_action or all_controller
				return true
			else
				return false
			end
		elsif controller and action == nil			
			all = Acl.find_by(role_id: rol_id, controller: controller, action: '[all]')
			all_controller = Acl.find_by(role_id: rol_id, controller: '[all]', action: '[all]');
			if all or all_controller
				return true
			else
				return false
			end
		elsif controller == nil and action
			return false
		else
			allall = Acl.find_by(role_id: rol_id, controller: '[all]', action: '[all]')
			if allall
				return true
			else
				return false
			end
		end

		return false
	end
end
