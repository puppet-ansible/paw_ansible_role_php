# paw_ansible_role_php
# @summary Manage paw_ansible_role_php configuration
#
# @param php_apc_shm_size
# @param php_apc_enable_cli
# @param php_fpm_daemon
# @param php_fpm_conf_path
# @param php_opcache_zend_extension OpCache settings.
# @param php_opcache_enable
# @param php_opcache_enable_cli
# @param php_opcache_memory_consumption
# @param php_opcache_interned_strings_buffer
# @param php_opcache_max_accelerated_files
# @param php_opcache_max_wasted_percentage
# @param php_opcache_validate_timestamps
# @param php_opcache_revalidate_path
# @param php_opcache_revalidate_freq
# @param php_opcache_max_file_size
# @param php_opcache_blacklist_filename
# @param php_short_open_tag
# @param php_precision
# @param php_output_buffering
# @param php_serialize_precision
# @param php_expose_php
# @param php_max_execution_time
# @param php_max_input_time
# @param php_max_input_vars
# @param php_memory_limit
# @param php_error_reporting
# @param php_display_errors
# @param php_display_startup_errors
# @param php_post_max_size
# @param php_realpath_cache_size
# @param php_file_uploads
# @param php_upload_max_filesize
# @param php_max_file_uploads
# @param php_allow_url_fopen
# @param php_date_timezone
# @param php_sendmail_path
# @param php_session_save_handler
# @param php_session_save_path
# @param php_session_cookie_lifetime
# @param php_session_gc_probability
# @param php_session_gc_divisor
# @param php_session_gc_maxlifetime
# @param php_fpm_pool_user
# @param php_fpm_pool_group
# @param php_enablerepo for RHEL/CentOS.
# @param php_packages_extra Extra packages to install (in addition to distro-specific default lists).
# @param php_packages_state you want to upgrade or switch versions using a new repo.
# @param php_install_recommends Whether to install recommended packages. Used only for Debian/Ubuntu.
# @param php_enable_webserver Set this to false if you're not using PHP with Apache/Nginx/etc.
# @param php_enable_php_fpm PHP-FPM configuration.
# @param php_fpm_state
# @param php_fpm_handler_state
# @param php_fpm_enabled_on_boot
# @param php_fpm_listen
# @param php_fpm_listen_allowed_clients
# @param php_fpm_pm_max_children
# @param php_fpm_pm_start_servers
# @param php_fpm_pm_min_spare_servers
# @param php_fpm_pm_max_spare_servers
# @param php_fpm_pm_max_requests
# @param php_fpm_pm_status_path
# @param php_fpm_pools PHP-FPM pool configuration.
# @param php_executable The executable to run when calling PHP from the command line.
# @param php_enable_apc APCu settings.
# @param php_use_managed_ini Any and all changes to /etc/php.ini will be your responsibility.
# @param php_disable_functions
# @param php_install_from_source Install PHP from source (instead of using a package manager) with these vars.
# @param php_source_repo
# @param php_source_version
# @param php_source_clone_dir
# @param php_source_clone_depth
# @param php_source_install_path
# @param php_source_install_gmp_path
# @param php_source_mysql_config
# @param php_source_make_command For faster compile time: "make --jobs=X" where X is # of cores present.
# @param php_source_configure_command
# @param par_vardir Base directory for Puppet agent cache (uses lookup('paw::par_vardir') for common config)
# @param par_tags An array of Ansible tags to execute (optional)
# @param par_skip_tags An array of Ansible tags to skip (optional)
# @param par_start_at_task The name of the task to start execution at (optional)
# @param par_limit Limit playbook execution to specific hosts (optional)
# @param par_verbose Enable verbose output from Ansible (optional)
# @param par_check_mode Run Ansible in check mode (dry-run) (optional)
# @param par_timeout Timeout in seconds for playbook execution (optional)
# @param par_user Remote user to use for Ansible connections (optional)
# @param par_env_vars Additional environment variables for ansible-playbook execution (optional)
# @param par_logoutput Control whether playbook output is displayed in Puppet logs (optional)
# @param par_exclusive Serialize playbook execution using a lock file (optional)
class paw_ansible_role_php (
  String $php_apc_shm_size = '96M',
  String $php_apc_enable_cli = '0',
  Optional[String] $php_fpm_daemon = undef,
  Optional[String] $php_fpm_conf_path = undef,
  String $php_opcache_zend_extension = 'opcache.so',
  String $php_opcache_enable = '1',
  String $php_opcache_enable_cli = '0',
  String $php_opcache_memory_consumption = '96',
  String $php_opcache_interned_strings_buffer = '16',
  String $php_opcache_max_accelerated_files = '4096',
  String $php_opcache_max_wasted_percentage = '5',
  String $php_opcache_validate_timestamps = '1',
  String $php_opcache_revalidate_path = '0',
  String $php_opcache_revalidate_freq = '2',
  String $php_opcache_max_file_size = '0',
  Optional[String] $php_opcache_blacklist_filename = undef,
  String $php_short_open_tag = 'Off',
  Integer $php_precision = 14,
  String $php_output_buffering = '4096',
  String $php_serialize_precision = '-1',
  String $php_expose_php = 'On',
  String $php_max_execution_time = '60',
  String $php_max_input_time = '60',
  String $php_max_input_vars = '1000',
  String $php_memory_limit = '256M',
  String $php_error_reporting = 'E_ALL & ~E_DEPRECATED & ~E_STRICT',
  String $php_display_errors = 'Off',
  String $php_display_startup_errors = 'Off',
  String $php_post_max_size = '32M',
  String $php_realpath_cache_size = '32K',
  String $php_file_uploads = 'On',
  String $php_upload_max_filesize = '64M',
  String $php_max_file_uploads = '20',
  String $php_allow_url_fopen = 'On',
  String $php_date_timezone = 'America/Chicago',
  String $php_sendmail_path = '/usr/sbin/sendmail -t -i',
  String $php_session_save_handler = 'files',
  Optional[String] $php_session_save_path = undef,
  Integer $php_session_cookie_lifetime = 0,
  Integer $php_session_gc_probability = 1,
  Integer $php_session_gc_divisor = 1000,
  Integer $php_session_gc_maxlifetime = 1440,
  Optional[String] $php_fpm_pool_user = undef,
  Optional[String] $php_fpm_pool_group = undef,
  Optional[String] $php_enablerepo = undef,
  Array $php_packages_extra = [],
  String $php_packages_state = 'present',
  Boolean $php_install_recommends = true,
  Boolean $php_enable_webserver = true,
  Boolean $php_enable_php_fpm = false,
  String $php_fpm_state = 'started',
  String $php_fpm_handler_state = 'restarted',
  Boolean $php_fpm_enabled_on_boot = true,
  String $php_fpm_listen = '127.0.0.1:9000',
  String $php_fpm_listen_allowed_clients = '127.0.0.1',
  Integer $php_fpm_pm_max_children = 50,
  Integer $php_fpm_pm_start_servers = 5,
  Integer $php_fpm_pm_min_spare_servers = 5,
  Integer $php_fpm_pm_max_spare_servers = 5,
  Integer $php_fpm_pm_max_requests = 0,
  Optional[String] $php_fpm_pm_status_path = undef,
  Array $php_fpm_pools = [{'pool_name' => 'www', 'pool_template' => 'www.conf.j2', 'pool_listen' => '{{ php_fpm_listen }}', 'pool_listen_allowed_clients' => '{{ php_fpm_listen_allowed_clients }}', 'pool_pm' => 'dynamic', 'pool_pm_max_children' => '{{ php_fpm_pm_max_children }}', 'pool_pm_start_servers' => '{{ php_fpm_pm_start_servers }}', 'pool_pm_min_spare_servers' => '{{ php_fpm_pm_min_spare_servers }}', 'pool_pm_max_spare_servers' => '{{ php_fpm_pm_max_spare_servers }}', 'pool_pm_max_requests' => '{{ php_fpm_pm_max_requests }}', 'pool_pm_status_path' => '{{ php_fpm_pm_status_path }}'}],
  String $php_executable = 'php',
  Boolean $php_enable_apc = true,
  Boolean $php_use_managed_ini = true,
  Array $php_disable_functions = [],
  Boolean $php_install_from_source = false,
  String $php_source_repo = 'https://github.com/php/php-src.git',
  String $php_source_version = 'master',
  String $php_source_clone_dir = '~/php-src',
  Integer $php_source_clone_depth = 1,
  String $php_source_install_path = '/opt/php',
  String $php_source_install_gmp_path = '/usr/include/x86_64-linux-gnu/gmp.h',
  String $php_source_mysql_config = '/usr/bin/mysql_config',
  String $php_source_make_command = 'make',
  String $php_source_configure_command = './configure --prefix={{ php_source_install_path }} --with-config-file-path={{ php_conf_paths | first }} --enable-mbstring --enable-zip --enable-bcmath --enable-pcntl --enable-ftp --enable-exif --enable-calendar --enable-opcache --enable-pdo --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --with-curl --with-mcrypt --with-iconv --with-gmp --with-pspell --with-gd --with-jpeg-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr --with-xpm-dir=/usr --with-freetype-dir=/usr --enable-gd-native-ttf --enable-gd-jis-conv --with-openssl --with-pdo-mysql=/usr --with-gettext=/usr --with-zlib=/usr --with-bz2=/usr --with-recode=/usr --with-mysqli={{ php_source_mysql_config }}\n',
  Optional[Stdlib::Absolutepath] $par_vardir = undef,
  Optional[Array[String]] $par_tags = undef,
  Optional[Array[String]] $par_skip_tags = undef,
  Optional[String] $par_start_at_task = undef,
  Optional[String] $par_limit = undef,
  Optional[Boolean] $par_verbose = undef,
  Optional[Boolean] $par_check_mode = undef,
  Optional[Integer] $par_timeout = undef,
  Optional[String] $par_user = undef,
  Optional[Hash] $par_env_vars = undef,
  Optional[Boolean] $par_logoutput = undef,
  Optional[Boolean] $par_exclusive = undef
) {
# Execute the Ansible role using PAR (Puppet Ansible Runner)
# Playbook synced via pluginsync to agent's cache directory
# Check for common paw::par_vardir setting, then module-specific, then default
$_par_vardir = $par_vardir ? {
  undef   => lookup('paw::par_vardir', Stdlib::Absolutepath, 'first', '/opt/puppetlabs/puppet/cache'),
  default => $par_vardir,
}
$playbook_path = "${_par_vardir}/lib/puppet_x/ansible_modules/ansible_role_php/playbook.yml"

par { 'paw_ansible_role_php-main':
  ensure        => present,
  playbook      => $playbook_path,
  playbook_vars => {
        'php_apc_shm_size' => $php_apc_shm_size,
        'php_apc_enable_cli' => $php_apc_enable_cli,
        'php_fpm_daemon' => $php_fpm_daemon,
        'php_fpm_conf_path' => $php_fpm_conf_path,
        'php_opcache_zend_extension' => $php_opcache_zend_extension,
        'php_opcache_enable' => $php_opcache_enable,
        'php_opcache_enable_cli' => $php_opcache_enable_cli,
        'php_opcache_memory_consumption' => $php_opcache_memory_consumption,
        'php_opcache_interned_strings_buffer' => $php_opcache_interned_strings_buffer,
        'php_opcache_max_accelerated_files' => $php_opcache_max_accelerated_files,
        'php_opcache_max_wasted_percentage' => $php_opcache_max_wasted_percentage,
        'php_opcache_validate_timestamps' => $php_opcache_validate_timestamps,
        'php_opcache_revalidate_path' => $php_opcache_revalidate_path,
        'php_opcache_revalidate_freq' => $php_opcache_revalidate_freq,
        'php_opcache_max_file_size' => $php_opcache_max_file_size,
        'php_opcache_blacklist_filename' => $php_opcache_blacklist_filename,
        'php_short_open_tag' => $php_short_open_tag,
        'php_precision' => $php_precision,
        'php_output_buffering' => $php_output_buffering,
        'php_serialize_precision' => $php_serialize_precision,
        'php_expose_php' => $php_expose_php,
        'php_max_execution_time' => $php_max_execution_time,
        'php_max_input_time' => $php_max_input_time,
        'php_max_input_vars' => $php_max_input_vars,
        'php_memory_limit' => $php_memory_limit,
        'php_error_reporting' => $php_error_reporting,
        'php_display_errors' => $php_display_errors,
        'php_display_startup_errors' => $php_display_startup_errors,
        'php_post_max_size' => $php_post_max_size,
        'php_realpath_cache_size' => $php_realpath_cache_size,
        'php_file_uploads' => $php_file_uploads,
        'php_upload_max_filesize' => $php_upload_max_filesize,
        'php_max_file_uploads' => $php_max_file_uploads,
        'php_allow_url_fopen' => $php_allow_url_fopen,
        'php_date_timezone' => $php_date_timezone,
        'php_sendmail_path' => $php_sendmail_path,
        'php_session_save_handler' => $php_session_save_handler,
        'php_session_save_path' => $php_session_save_path,
        'php_session_cookie_lifetime' => $php_session_cookie_lifetime,
        'php_session_gc_probability' => $php_session_gc_probability,
        'php_session_gc_divisor' => $php_session_gc_divisor,
        'php_session_gc_maxlifetime' => $php_session_gc_maxlifetime,
        'php_fpm_pool_user' => $php_fpm_pool_user,
        'php_fpm_pool_group' => $php_fpm_pool_group,
        'php_enablerepo' => $php_enablerepo,
        'php_packages_extra' => $php_packages_extra,
        'php_packages_state' => $php_packages_state,
        'php_install_recommends' => $php_install_recommends,
        'php_enable_webserver' => $php_enable_webserver,
        'php_enable_php_fpm' => $php_enable_php_fpm,
        'php_fpm_state' => $php_fpm_state,
        'php_fpm_handler_state' => $php_fpm_handler_state,
        'php_fpm_enabled_on_boot' => $php_fpm_enabled_on_boot,
        'php_fpm_listen' => $php_fpm_listen,
        'php_fpm_listen_allowed_clients' => $php_fpm_listen_allowed_clients,
        'php_fpm_pm_max_children' => $php_fpm_pm_max_children,
        'php_fpm_pm_start_servers' => $php_fpm_pm_start_servers,
        'php_fpm_pm_min_spare_servers' => $php_fpm_pm_min_spare_servers,
        'php_fpm_pm_max_spare_servers' => $php_fpm_pm_max_spare_servers,
        'php_fpm_pm_max_requests' => $php_fpm_pm_max_requests,
        'php_fpm_pm_status_path' => $php_fpm_pm_status_path,
        'php_fpm_pools' => $php_fpm_pools,
        'php_executable' => $php_executable,
        'php_enable_apc' => $php_enable_apc,
        'php_use_managed_ini' => $php_use_managed_ini,
        'php_disable_functions' => $php_disable_functions,
        'php_install_from_source' => $php_install_from_source,
        'php_source_repo' => $php_source_repo,
        'php_source_version' => $php_source_version,
        'php_source_clone_dir' => $php_source_clone_dir,
        'php_source_clone_depth' => $php_source_clone_depth,
        'php_source_install_path' => $php_source_install_path,
        'php_source_install_gmp_path' => $php_source_install_gmp_path,
        'php_source_mysql_config' => $php_source_mysql_config,
        'php_source_make_command' => $php_source_make_command,
        'php_source_configure_command' => $php_source_configure_command
              },
  tags          => $par_tags,
  skip_tags     => $par_skip_tags,
  start_at_task => $par_start_at_task,
  limit         => $par_limit,
  verbose       => $par_verbose,
  check_mode    => $par_check_mode,
  timeout       => $par_timeout,
  user          => $par_user,
  env_vars      => $par_env_vars,
  logoutput     => $par_logoutput,
  exclusive     => $par_exclusive,
}
}
