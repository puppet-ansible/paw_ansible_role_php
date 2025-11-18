# Puppet task for executing Ansible role: ansible_role_php
# This script runs the entire role via ansible-playbook

$ErrorActionPreference = 'Stop'

# Determine the ansible modules directory
if ($env:PT__installdir) {
  $AnsibleDir = Join-Path $env:PT__installdir "lib\puppet_x\ansible_modules\ansible_role_php"
} else {
  # Fallback to Puppet cache directory
  $AnsibleDir = "C:\ProgramData\PuppetLabs\puppet\cache\lib\puppet_x\ansible_modules\ansible_role_php"
}

# Check if ansible-playbook is available
$AnsiblePlaybook = Get-Command ansible-playbook -ErrorAction SilentlyContinue
if (-not $AnsiblePlaybook) {
  $result = @{
    _error = @{
      msg = "ansible-playbook command not found. Please install Ansible."
      kind = "puppet-ansible-converter/ansible-not-found"
    }
  }
  Write-Output ($result | ConvertTo-Json)
  exit 1
}

# Check if the role directory exists
if (-not (Test-Path $AnsibleDir)) {
  $result = @{
    _error = @{
      msg = "Ansible role directory not found: $AnsibleDir"
      kind = "puppet-ansible-converter/role-not-found"
    }
  }
  Write-Output ($result | ConvertTo-Json)
  exit 1
}

# Detect playbook location (collection vs standalone)
# Collections: ansible_modules/collection_name/roles/role_name/playbook.yml
# Standalone: ansible_modules/role_name/playbook.yml
$CollectionPlaybook = Join-Path $AnsibleDir "roles\paw_ansible_role_php\playbook.yml"
$StandalonePlaybook = Join-Path $AnsibleDir "playbook.yml"

if ((Test-Path (Join-Path $AnsibleDir "roles")) -and (Test-Path $CollectionPlaybook)) {
  # Collection structure
  $PlaybookPath = $CollectionPlaybook
  $PlaybookDir = Join-Path $AnsibleDir "roles\paw_ansible_role_php"
} elseif (Test-Path $StandalonePlaybook) {
  # Standalone role structure
  $PlaybookPath = $StandalonePlaybook
  $PlaybookDir = $AnsibleDir
} else {
  $result = @{
    _error = @{
      msg = "playbook.yml not found in $AnsibleDir or $AnsibleDir\roles\paw_ansible_role_php"
      kind = "puppet-ansible-converter/playbook-not-found"
    }
  }
  Write-Output ($result | ConvertTo-Json)
  exit 1
}

# Build extra-vars from PT_* environment variables
$ExtraVars = @{}
if ($env:PT_php_apc_shm_size) {
  $ExtraVars['php_apc_shm_size'] = $env:PT_php_apc_shm_size
}
if ($env:PT_php_apc_enable_cli) {
  $ExtraVars['php_apc_enable_cli'] = $env:PT_php_apc_enable_cli
}
if ($env:PT_php_fpm_daemon) {
  $ExtraVars['php_fpm_daemon'] = $env:PT_php_fpm_daemon
}
if ($env:PT_php_fpm_conf_path) {
  $ExtraVars['php_fpm_conf_path'] = $env:PT_php_fpm_conf_path
}
if ($env:PT_php_opcache_zend_extension) {
  $ExtraVars['php_opcache_zend_extension'] = $env:PT_php_opcache_zend_extension
}
if ($env:PT_php_opcache_enable) {
  $ExtraVars['php_opcache_enable'] = $env:PT_php_opcache_enable
}
if ($env:PT_php_opcache_enable_cli) {
  $ExtraVars['php_opcache_enable_cli'] = $env:PT_php_opcache_enable_cli
}
if ($env:PT_php_opcache_memory_consumption) {
  $ExtraVars['php_opcache_memory_consumption'] = $env:PT_php_opcache_memory_consumption
}
if ($env:PT_php_opcache_interned_strings_buffer) {
  $ExtraVars['php_opcache_interned_strings_buffer'] = $env:PT_php_opcache_interned_strings_buffer
}
if ($env:PT_php_opcache_max_accelerated_files) {
  $ExtraVars['php_opcache_max_accelerated_files'] = $env:PT_php_opcache_max_accelerated_files
}
if ($env:PT_php_opcache_max_wasted_percentage) {
  $ExtraVars['php_opcache_max_wasted_percentage'] = $env:PT_php_opcache_max_wasted_percentage
}
if ($env:PT_php_opcache_validate_timestamps) {
  $ExtraVars['php_opcache_validate_timestamps'] = $env:PT_php_opcache_validate_timestamps
}
if ($env:PT_php_opcache_revalidate_path) {
  $ExtraVars['php_opcache_revalidate_path'] = $env:PT_php_opcache_revalidate_path
}
if ($env:PT_php_opcache_revalidate_freq) {
  $ExtraVars['php_opcache_revalidate_freq'] = $env:PT_php_opcache_revalidate_freq
}
if ($env:PT_php_opcache_max_file_size) {
  $ExtraVars['php_opcache_max_file_size'] = $env:PT_php_opcache_max_file_size
}
if ($env:PT_php_opcache_blacklist_filename) {
  $ExtraVars['php_opcache_blacklist_filename'] = $env:PT_php_opcache_blacklist_filename
}
if ($env:PT_php_short_open_tag) {
  $ExtraVars['php_short_open_tag'] = $env:PT_php_short_open_tag
}
if ($env:PT_php_precision) {
  $ExtraVars['php_precision'] = $env:PT_php_precision
}
if ($env:PT_php_output_buffering) {
  $ExtraVars['php_output_buffering'] = $env:PT_php_output_buffering
}
if ($env:PT_php_serialize_precision) {
  $ExtraVars['php_serialize_precision'] = $env:PT_php_serialize_precision
}
if ($env:PT_php_expose_php) {
  $ExtraVars['php_expose_php'] = $env:PT_php_expose_php
}
if ($env:PT_php_max_execution_time) {
  $ExtraVars['php_max_execution_time'] = $env:PT_php_max_execution_time
}
if ($env:PT_php_max_input_time) {
  $ExtraVars['php_max_input_time'] = $env:PT_php_max_input_time
}
if ($env:PT_php_max_input_vars) {
  $ExtraVars['php_max_input_vars'] = $env:PT_php_max_input_vars
}
if ($env:PT_php_memory_limit) {
  $ExtraVars['php_memory_limit'] = $env:PT_php_memory_limit
}
if ($env:PT_php_error_reporting) {
  $ExtraVars['php_error_reporting'] = $env:PT_php_error_reporting
}
if ($env:PT_php_display_errors) {
  $ExtraVars['php_display_errors'] = $env:PT_php_display_errors
}
if ($env:PT_php_display_startup_errors) {
  $ExtraVars['php_display_startup_errors'] = $env:PT_php_display_startup_errors
}
if ($env:PT_php_post_max_size) {
  $ExtraVars['php_post_max_size'] = $env:PT_php_post_max_size
}
if ($env:PT_php_realpath_cache_size) {
  $ExtraVars['php_realpath_cache_size'] = $env:PT_php_realpath_cache_size
}
if ($env:PT_php_file_uploads) {
  $ExtraVars['php_file_uploads'] = $env:PT_php_file_uploads
}
if ($env:PT_php_upload_max_filesize) {
  $ExtraVars['php_upload_max_filesize'] = $env:PT_php_upload_max_filesize
}
if ($env:PT_php_max_file_uploads) {
  $ExtraVars['php_max_file_uploads'] = $env:PT_php_max_file_uploads
}
if ($env:PT_php_allow_url_fopen) {
  $ExtraVars['php_allow_url_fopen'] = $env:PT_php_allow_url_fopen
}
if ($env:PT_php_date_timezone) {
  $ExtraVars['php_date_timezone'] = $env:PT_php_date_timezone
}
if ($env:PT_php_sendmail_path) {
  $ExtraVars['php_sendmail_path'] = $env:PT_php_sendmail_path
}
if ($env:PT_php_session_save_handler) {
  $ExtraVars['php_session_save_handler'] = $env:PT_php_session_save_handler
}
if ($env:PT_php_session_save_path) {
  $ExtraVars['php_session_save_path'] = $env:PT_php_session_save_path
}
if ($env:PT_php_session_cookie_lifetime) {
  $ExtraVars['php_session_cookie_lifetime'] = $env:PT_php_session_cookie_lifetime
}
if ($env:PT_php_session_gc_probability) {
  $ExtraVars['php_session_gc_probability'] = $env:PT_php_session_gc_probability
}
if ($env:PT_php_session_gc_divisor) {
  $ExtraVars['php_session_gc_divisor'] = $env:PT_php_session_gc_divisor
}
if ($env:PT_php_session_gc_maxlifetime) {
  $ExtraVars['php_session_gc_maxlifetime'] = $env:PT_php_session_gc_maxlifetime
}
if ($env:PT_php_fpm_pool_user) {
  $ExtraVars['php_fpm_pool_user'] = $env:PT_php_fpm_pool_user
}
if ($env:PT_php_fpm_pool_group) {
  $ExtraVars['php_fpm_pool_group'] = $env:PT_php_fpm_pool_group
}
if ($env:PT_php_enablerepo) {
  $ExtraVars['php_enablerepo'] = $env:PT_php_enablerepo
}
if ($env:PT_php_packages_extra) {
  $ExtraVars['php_packages_extra'] = $env:PT_php_packages_extra
}
if ($env:PT_php_packages_state) {
  $ExtraVars['php_packages_state'] = $env:PT_php_packages_state
}
if ($env:PT_php_install_recommends) {
  $ExtraVars['php_install_recommends'] = $env:PT_php_install_recommends
}
if ($env:PT_php_enable_webserver) {
  $ExtraVars['php_enable_webserver'] = $env:PT_php_enable_webserver
}
if ($env:PT_php_enable_php_fpm) {
  $ExtraVars['php_enable_php_fpm'] = $env:PT_php_enable_php_fpm
}
if ($env:PT_php_fpm_state) {
  $ExtraVars['php_fpm_state'] = $env:PT_php_fpm_state
}
if ($env:PT_php_fpm_handler_state) {
  $ExtraVars['php_fpm_handler_state'] = $env:PT_php_fpm_handler_state
}
if ($env:PT_php_fpm_enabled_on_boot) {
  $ExtraVars['php_fpm_enabled_on_boot'] = $env:PT_php_fpm_enabled_on_boot
}
if ($env:PT_php_fpm_listen) {
  $ExtraVars['php_fpm_listen'] = $env:PT_php_fpm_listen
}
if ($env:PT_php_fpm_listen_allowed_clients) {
  $ExtraVars['php_fpm_listen_allowed_clients'] = $env:PT_php_fpm_listen_allowed_clients
}
if ($env:PT_php_fpm_pm_max_children) {
  $ExtraVars['php_fpm_pm_max_children'] = $env:PT_php_fpm_pm_max_children
}
if ($env:PT_php_fpm_pm_start_servers) {
  $ExtraVars['php_fpm_pm_start_servers'] = $env:PT_php_fpm_pm_start_servers
}
if ($env:PT_php_fpm_pm_min_spare_servers) {
  $ExtraVars['php_fpm_pm_min_spare_servers'] = $env:PT_php_fpm_pm_min_spare_servers
}
if ($env:PT_php_fpm_pm_max_spare_servers) {
  $ExtraVars['php_fpm_pm_max_spare_servers'] = $env:PT_php_fpm_pm_max_spare_servers
}
if ($env:PT_php_fpm_pm_max_requests) {
  $ExtraVars['php_fpm_pm_max_requests'] = $env:PT_php_fpm_pm_max_requests
}
if ($env:PT_php_fpm_pm_status_path) {
  $ExtraVars['php_fpm_pm_status_path'] = $env:PT_php_fpm_pm_status_path
}
if ($env:PT_php_fpm_pools) {
  $ExtraVars['php_fpm_pools'] = $env:PT_php_fpm_pools
}
if ($env:PT_php_executable) {
  $ExtraVars['php_executable'] = $env:PT_php_executable
}
if ($env:PT_php_enable_apc) {
  $ExtraVars['php_enable_apc'] = $env:PT_php_enable_apc
}
if ($env:PT_php_use_managed_ini) {
  $ExtraVars['php_use_managed_ini'] = $env:PT_php_use_managed_ini
}
if ($env:PT_php_disable_functions) {
  $ExtraVars['php_disable_functions'] = $env:PT_php_disable_functions
}
if ($env:PT_php_install_from_source) {
  $ExtraVars['php_install_from_source'] = $env:PT_php_install_from_source
}
if ($env:PT_php_source_repo) {
  $ExtraVars['php_source_repo'] = $env:PT_php_source_repo
}
if ($env:PT_php_source_version) {
  $ExtraVars['php_source_version'] = $env:PT_php_source_version
}
if ($env:PT_php_source_clone_dir) {
  $ExtraVars['php_source_clone_dir'] = $env:PT_php_source_clone_dir
}
if ($env:PT_php_source_clone_depth) {
  $ExtraVars['php_source_clone_depth'] = $env:PT_php_source_clone_depth
}
if ($env:PT_php_source_install_path) {
  $ExtraVars['php_source_install_path'] = $env:PT_php_source_install_path
}
if ($env:PT_php_source_install_gmp_path) {
  $ExtraVars['php_source_install_gmp_path'] = $env:PT_php_source_install_gmp_path
}
if ($env:PT_php_source_mysql_config) {
  $ExtraVars['php_source_mysql_config'] = $env:PT_php_source_mysql_config
}
if ($env:PT_php_source_make_command) {
  $ExtraVars['php_source_make_command'] = $env:PT_php_source_make_command
}
if ($env:PT_php_source_configure_command) {
  $ExtraVars['php_source_configure_command'] = $env:PT_php_source_configure_command
}

$ExtraVarsJson = $ExtraVars | ConvertTo-Json -Compress

# Execute ansible-playbook with the role
Push-Location $PlaybookDir
try {
  ansible-playbook playbook.yml `
    --extra-vars $ExtraVarsJson `
    --connection=local `
    --inventory=localhost, `
    2>&1 | Write-Output
  
  $ExitCode = $LASTEXITCODE
  
  if ($ExitCode -eq 0) {
    $result = @{
      status = "success"
      role = "ansible_role_php"
    }
  } else {
    $result = @{
      status = "failed"
      role = "ansible_role_php"
      exit_code = $ExitCode
    }
  }
  
  Write-Output ($result | ConvertTo-Json)
  exit $ExitCode
}
finally {
  Pop-Location
}
