# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Create first permission to manage everything in the app, Super Admin role and user with this role
tenant = Tenant.find_or_create_by(name: 'Company')
RLS.set_tenant tenant
global_permission = Permission.create(subject_class: 'all', action: 'manage', subject_name: 'All', action_name: 'All', tenant: tenant)
role = Role.create(name: 'Super Admin', tenant: tenant)
role.role_permissions.create(tenant: tenant, permission: global_permission)
User.create(username: 'admin', name: 'Super Admin', email: 'admin@example.com',
            password: 'strong_password', password_confirmation: 'strong_password',
            role: role, tenant: tenant)
