# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Set current tenant
tenant = Tenant.find_or_create_by(name: 'Company')
RLS.set_tenant tenant

# Create first permission to manage everything in the app, Super Admin role and user with this role
global_permission = Permission.create(subject_class: 'all', action: 'manage', subject_name: 'All', action_name: 'All', tenant: tenant)
role = Role.create(name: 'Super Admin', permissions: [global_permission], tenant: tenant)
User.create(username: 'admin', name: 'Super Admin', email: 'admin@example.com',
            password: 'strong_password', password_confirmation: 'strong_password',
            role: role, tenant: tenant)
