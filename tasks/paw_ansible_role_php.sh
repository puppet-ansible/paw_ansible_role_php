#!/bin/bash
set -e

# Puppet task for executing Ansible role: ansible_role_php
# This script runs the entire role via ansible-playbook

# Determine the ansible modules directory
if [ -n "$PT__installdir" ]; then
  ANSIBLE_DIR="$PT__installdir/lib/puppet_x/ansible_modules/ansible_role_php"
else
  # Fallback to /opt/puppetlabs/puppet/cache/lib/puppet_x/ansible_modules
  ANSIBLE_DIR="/opt/puppetlabs/puppet/cache/lib/puppet_x/ansible_modules/ansible_role_php"
fi

# Check if ansible-playbook is available
if ! command -v ansible-playbook &> /dev/null; then
  echo '{"_error": {"msg": "ansible-playbook command not found. Please install Ansible.", "kind": "puppet-ansible-converter/ansible-not-found"}}'
  exit 1
fi

# Check if the role directory exists
if [ ! -d "$ANSIBLE_DIR" ]; then
  echo "{\"_error\": {\"msg\": \"Ansible role directory not found: $ANSIBLE_DIR\", \"kind\": \"puppet-ansible-converter/role-not-found\"}}"
  exit 1
fi

# Detect playbook location (collection vs standalone)
# Collections: ansible_modules/collection_name/roles/role_name/playbook.yml
# Standalone: ansible_modules/role_name/playbook.yml
if [ -d "$ANSIBLE_DIR/roles" ] && [ -f "$ANSIBLE_DIR/roles/paw_ansible_role_php/playbook.yml" ]; then
  # Collection structure
  PLAYBOOK_PATH="$ANSIBLE_DIR/roles/paw_ansible_role_php/playbook.yml"
  PLAYBOOK_DIR="$ANSIBLE_DIR/roles/paw_ansible_role_php"
elif [ -f "$ANSIBLE_DIR/playbook.yml" ]; then
  # Standalone role structure
  PLAYBOOK_PATH="$ANSIBLE_DIR/playbook.yml"
  PLAYBOOK_DIR="$ANSIBLE_DIR"
else
  echo "{\"_error\": {\"msg\": \"playbook.yml not found in $ANSIBLE_DIR or $ANSIBLE_DIR/roles/paw_ansible_role_php\", \"kind\": \"puppet-ansible-converter/playbook-not-found\"}}"
  exit 1
fi

# Build extra-vars from PT_* environment variables (excluding par_* control params)
EXTRA_VARS="{"
FIRST=true
if [ -n "$PT_php_apc_shm_size" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_apc_shm_size\": \"$PT_php_apc_shm_size\""
fi
if [ -n "$PT_php_apc_enable_cli" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_apc_enable_cli\": \"$PT_php_apc_enable_cli\""
fi
if [ -n "$PT_php_fpm_daemon" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_daemon\": \"$PT_php_fpm_daemon\""
fi
if [ -n "$PT_php_fpm_conf_path" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_conf_path\": \"$PT_php_fpm_conf_path\""
fi
if [ -n "$PT_php_opcache_zend_extension" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_zend_extension\": \"$PT_php_opcache_zend_extension\""
fi
if [ -n "$PT_php_opcache_enable" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_enable\": \"$PT_php_opcache_enable\""
fi
if [ -n "$PT_php_opcache_enable_cli" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_enable_cli\": \"$PT_php_opcache_enable_cli\""
fi
if [ -n "$PT_php_opcache_memory_consumption" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_memory_consumption\": \"$PT_php_opcache_memory_consumption\""
fi
if [ -n "$PT_php_opcache_interned_strings_buffer" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_interned_strings_buffer\": \"$PT_php_opcache_interned_strings_buffer\""
fi
if [ -n "$PT_php_opcache_max_accelerated_files" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_max_accelerated_files\": \"$PT_php_opcache_max_accelerated_files\""
fi
if [ -n "$PT_php_opcache_max_wasted_percentage" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_max_wasted_percentage\": \"$PT_php_opcache_max_wasted_percentage\""
fi
if [ -n "$PT_php_opcache_validate_timestamps" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_validate_timestamps\": \"$PT_php_opcache_validate_timestamps\""
fi
if [ -n "$PT_php_opcache_revalidate_path" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_revalidate_path\": \"$PT_php_opcache_revalidate_path\""
fi
if [ -n "$PT_php_opcache_revalidate_freq" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_revalidate_freq\": \"$PT_php_opcache_revalidate_freq\""
fi
if [ -n "$PT_php_opcache_max_file_size" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_max_file_size\": \"$PT_php_opcache_max_file_size\""
fi
if [ -n "$PT_php_opcache_blacklist_filename" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_opcache_blacklist_filename\": \"$PT_php_opcache_blacklist_filename\""
fi
if [ -n "$PT_php_short_open_tag" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_short_open_tag\": \"$PT_php_short_open_tag\""
fi
if [ -n "$PT_php_precision" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_precision\": \"$PT_php_precision\""
fi
if [ -n "$PT_php_output_buffering" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_output_buffering\": \"$PT_php_output_buffering\""
fi
if [ -n "$PT_php_serialize_precision" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_serialize_precision\": \"$PT_php_serialize_precision\""
fi
if [ -n "$PT_php_expose_php" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_expose_php\": \"$PT_php_expose_php\""
fi
if [ -n "$PT_php_max_execution_time" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_max_execution_time\": \"$PT_php_max_execution_time\""
fi
if [ -n "$PT_php_max_input_time" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_max_input_time\": \"$PT_php_max_input_time\""
fi
if [ -n "$PT_php_max_input_vars" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_max_input_vars\": \"$PT_php_max_input_vars\""
fi
if [ -n "$PT_php_memory_limit" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_memory_limit\": \"$PT_php_memory_limit\""
fi
if [ -n "$PT_php_error_reporting" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_error_reporting\": \"$PT_php_error_reporting\""
fi
if [ -n "$PT_php_display_errors" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_display_errors\": \"$PT_php_display_errors\""
fi
if [ -n "$PT_php_display_startup_errors" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_display_startup_errors\": \"$PT_php_display_startup_errors\""
fi
if [ -n "$PT_php_post_max_size" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_post_max_size\": \"$PT_php_post_max_size\""
fi
if [ -n "$PT_php_realpath_cache_size" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_realpath_cache_size\": \"$PT_php_realpath_cache_size\""
fi
if [ -n "$PT_php_file_uploads" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_file_uploads\": \"$PT_php_file_uploads\""
fi
if [ -n "$PT_php_upload_max_filesize" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_upload_max_filesize\": \"$PT_php_upload_max_filesize\""
fi
if [ -n "$PT_php_max_file_uploads" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_max_file_uploads\": \"$PT_php_max_file_uploads\""
fi
if [ -n "$PT_php_allow_url_fopen" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_allow_url_fopen\": \"$PT_php_allow_url_fopen\""
fi
if [ -n "$PT_php_date_timezone" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_date_timezone\": \"$PT_php_date_timezone\""
fi
if [ -n "$PT_php_sendmail_path" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_sendmail_path\": \"$PT_php_sendmail_path\""
fi
if [ -n "$PT_php_session_save_handler" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_session_save_handler\": \"$PT_php_session_save_handler\""
fi
if [ -n "$PT_php_session_save_path" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_session_save_path\": \"$PT_php_session_save_path\""
fi
if [ -n "$PT_php_session_cookie_lifetime" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_session_cookie_lifetime\": \"$PT_php_session_cookie_lifetime\""
fi
if [ -n "$PT_php_session_gc_probability" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_session_gc_probability\": \"$PT_php_session_gc_probability\""
fi
if [ -n "$PT_php_session_gc_divisor" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_session_gc_divisor\": \"$PT_php_session_gc_divisor\""
fi
if [ -n "$PT_php_session_gc_maxlifetime" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_session_gc_maxlifetime\": \"$PT_php_session_gc_maxlifetime\""
fi
if [ -n "$PT_php_fpm_pool_user" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pool_user\": \"$PT_php_fpm_pool_user\""
fi
if [ -n "$PT_php_fpm_pool_group" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pool_group\": \"$PT_php_fpm_pool_group\""
fi
if [ -n "$PT_php_enablerepo" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_enablerepo\": \"$PT_php_enablerepo\""
fi
if [ -n "$PT_php_packages_extra" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_packages_extra\": \"$PT_php_packages_extra\""
fi
if [ -n "$PT_php_packages_state" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_packages_state\": \"$PT_php_packages_state\""
fi
if [ -n "$PT_php_install_recommends" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_install_recommends\": \"$PT_php_install_recommends\""
fi
if [ -n "$PT_php_enable_webserver" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_enable_webserver\": \"$PT_php_enable_webserver\""
fi
if [ -n "$PT_php_enable_php_fpm" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_enable_php_fpm\": \"$PT_php_enable_php_fpm\""
fi
if [ -n "$PT_php_fpm_state" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_state\": \"$PT_php_fpm_state\""
fi
if [ -n "$PT_php_fpm_handler_state" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_handler_state\": \"$PT_php_fpm_handler_state\""
fi
if [ -n "$PT_php_fpm_enabled_on_boot" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_enabled_on_boot\": \"$PT_php_fpm_enabled_on_boot\""
fi
if [ -n "$PT_php_fpm_listen" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_listen\": \"$PT_php_fpm_listen\""
fi
if [ -n "$PT_php_fpm_listen_allowed_clients" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_listen_allowed_clients\": \"$PT_php_fpm_listen_allowed_clients\""
fi
if [ -n "$PT_php_fpm_pm_max_children" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pm_max_children\": \"$PT_php_fpm_pm_max_children\""
fi
if [ -n "$PT_php_fpm_pm_start_servers" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pm_start_servers\": \"$PT_php_fpm_pm_start_servers\""
fi
if [ -n "$PT_php_fpm_pm_min_spare_servers" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pm_min_spare_servers\": \"$PT_php_fpm_pm_min_spare_servers\""
fi
if [ -n "$PT_php_fpm_pm_max_spare_servers" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pm_max_spare_servers\": \"$PT_php_fpm_pm_max_spare_servers\""
fi
if [ -n "$PT_php_fpm_pm_max_requests" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pm_max_requests\": \"$PT_php_fpm_pm_max_requests\""
fi
if [ -n "$PT_php_fpm_pm_status_path" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pm_status_path\": \"$PT_php_fpm_pm_status_path\""
fi
if [ -n "$PT_php_fpm_pools" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_fpm_pools\": \"$PT_php_fpm_pools\""
fi
if [ -n "$PT_php_executable" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_executable\": \"$PT_php_executable\""
fi
if [ -n "$PT_php_enable_apc" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_enable_apc\": \"$PT_php_enable_apc\""
fi
if [ -n "$PT_php_use_managed_ini" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_use_managed_ini\": \"$PT_php_use_managed_ini\""
fi
if [ -n "$PT_php_disable_functions" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_disable_functions\": \"$PT_php_disable_functions\""
fi
if [ -n "$PT_php_install_from_source" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_install_from_source\": \"$PT_php_install_from_source\""
fi
if [ -n "$PT_php_source_repo" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_repo\": \"$PT_php_source_repo\""
fi
if [ -n "$PT_php_source_version" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_version\": \"$PT_php_source_version\""
fi
if [ -n "$PT_php_source_clone_dir" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_clone_dir\": \"$PT_php_source_clone_dir\""
fi
if [ -n "$PT_php_source_clone_depth" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_clone_depth\": \"$PT_php_source_clone_depth\""
fi
if [ -n "$PT_php_source_install_path" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_install_path\": \"$PT_php_source_install_path\""
fi
if [ -n "$PT_php_source_install_gmp_path" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_install_gmp_path\": \"$PT_php_source_install_gmp_path\""
fi
if [ -n "$PT_php_source_mysql_config" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_mysql_config\": \"$PT_php_source_mysql_config\""
fi
if [ -n "$PT_php_source_make_command" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_make_command\": \"$PT_php_source_make_command\""
fi
if [ -n "$PT_php_source_configure_command" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"php_source_configure_command\": \"$PT_php_source_configure_command\""
fi
EXTRA_VARS="$EXTRA_VARS}"

# Build ansible-playbook command matching PAR provider exactly
# See: https://github.com/garrettrowell/puppet-par/blob/main/lib/puppet/provider/par/par.rb#L166
cd "$PLAYBOOK_DIR"

# Base command with inventory and connection (matching PAR)
ANSIBLE_CMD="ansible-playbook -i localhost, --connection=local"

# Add extra-vars (playbook variables)
ANSIBLE_CMD="$ANSIBLE_CMD -e \"$EXTRA_VARS\""

# Add tags if specified
if [ -n "$PT_par_tags" ]; then
  TAGS=$(echo "$PT_par_tags" | sed 's/\[//;s/\]//;s/"//g;s/,/,/g')
  ANSIBLE_CMD="$ANSIBLE_CMD --tags \"$TAGS\""
fi

# Add skip-tags if specified
if [ -n "$PT_par_skip_tags" ]; then
  SKIP_TAGS=$(echo "$PT_par_skip_tags" | sed 's/\[//;s/\]//;s/"//g;s/,/,/g')
  ANSIBLE_CMD="$ANSIBLE_CMD --skip-tags \"$SKIP_TAGS\""
fi

# Add start-at-task if specified
if [ -n "$PT_par_start_at_task" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --start-at-task \"$PT_par_start_at_task\""
fi

# Add limit if specified
if [ -n "$PT_par_limit" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --limit \"$PT_par_limit\""
fi

# Add verbose flag if specified
if [ "$PT_par_verbose" = "true" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD -v"
fi

# Add check mode flag if specified
if [ "$PT_par_check_mode" = "true" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --check"
fi

# Add user if specified
if [ -n "$PT_par_user" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --user \"$PT_par_user\""
fi

# Add timeout if specified
if [ -n "$PT_par_timeout" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --timeout $PT_par_timeout"
fi

# Add playbook path as last argument (matching PAR)
ANSIBLE_CMD="$ANSIBLE_CMD playbook.yml"

# Set environment variables if specified (matching PAR env_vars handling)
if [ -n "$PT_par_env_vars" ]; then
  # Parse JSON hash and export variables
  eval $(echo "$PT_par_env_vars" | sed 's/[{}]//g;s/": "/=/g;s/","/;export /g;s/"//g' | sed 's/^/export /')
fi

# Set required Ansible environment (matching PAR)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ANSIBLE_STDOUT_CALLBACK=json

# Execute ansible-playbook
eval $ANSIBLE_CMD 2>&1

EXIT_CODE=$?

# Return JSON result
if [ $EXIT_CODE -eq 0 ]; then
  echo '{"status": "success", "role": "ansible_role_php"}'
else
  echo "{\"status\": \"failed\", \"role\": \"ansible_role_php\", \"exit_code\": $EXIT_CODE}"
fi

exit $EXIT_CODE
