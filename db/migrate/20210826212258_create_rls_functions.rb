class CreateRlsFunctions < ActiveRecord::Migration[6.1]
  def self.up
    connection.execute <<-SQL

      -- This function returns the id of the current user or NULL if not set
      -- this varaible is set on a connection basis before every action
      -- If it is not set, it will return NULL and all non-public tables will seem empty.
      CREATE FUNCTION current_user_id() RETURNS BIGINT AS $$
      SELECT NULLIF(current_setting('rls.user_id', TRUE), '')::BIGINT;
      $$ LANGUAGE sql SECURITY DEFINER STABLE COST 10;

      -- This function returns the id of the current tenant or NULL if not set
      -- this varaible is set on a connection basis before every action
      -- If it is not set, it will return NULL and all non-public tables will seem empty.
      CREATE FUNCTION current_tenant_id() RETURNS BIGINT AS $$
        SELECT NULLIF(current_setting('rls.tenant_id', TRUE), '')::BIGINT;
      $$ LANGUAGE sql SECURITY DEFINER STABLE COST 10;

      -- This function sets an variable on a per connection (session) basis to signal
      -- that RLS should be ignore, this all policies should evaluate to true
      -- If this varaible is not set, the function returns FALSE.
      CREATE FUNCTION rls_disabled() RETURNS BOOLEAN AS $BODY$
        BEGIN
          -- Raise an error of RLS is not set up
          IF current_tenant_id()::BIGINT IS NULL AND current_setting('rls.disable', TRUE)::BOOLEAN IS NOT TRUE THEN
            RAISE EXCEPTION 'RLS not set up!' USING HINT = 'Please set rls.tenant_id or set rls.disable to FALSE.';
          END IF;

          RETURN COALESCE(current_setting('rls.disable', TRUE)::BOOLEAN, FALSE);
        END
      $BODY$ LANGUAGE plpgsql SECURITY DEFINER STABLE COST 12;
    SQL
  end

  def self.down
    connection.execute <<-SQL
      DROP FUNCTION IF EXISTS current_user_id CASCADE;
      DROP FUNCTION IF EXISTS current_tenant_id CASCADE;
      DROP FUNCTION IF EXISTS rls_disabled CASCADE;
     SQL
  end
end
