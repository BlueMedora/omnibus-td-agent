name 'td-agent-files'
# version '12' # git ref

dependency 'td-agent'

# This software setup td-agent related files, e.g. etc files.
# Separating file into td-agent.rb and td-agent-files.rb is for speed up package building


build do
  pkg_type = project.packagers_for_system.first.id.to_s
  install_path = project.install_dir # for ERB
  project_name = project.name # for ERB
  rb_major, rb_minor, = project.overrides[:ruby][:version].split('-', 2).first.split('.', 3)
  gem_dir_version = "#{rb_major}.#{rb_minor}.0" # gem path's teeny version is always 0
  install_message = 'Install successful'
  commander_name = 'fluent-commander'

  if File.exist?(File.join('INSTALL_MESSAGE'))
    install_message = File.read(File.join('INSTALL_MESSAGE'))
  end
  def sub_name(file)
    file.gsub('td-agent', project.name)
  end

  delete "#{project.package_scripts_path}/*"
  Dir.glob(File.join('package-scripts', 'td-agent', pkg_type, '*')).each do |src|
    dst = File.join(project.package_scripts_path, File.basename(src))
    mkdir File.dirname(dst)
    erb source: src,
        dest: sub_name(dst),
        mode: 0o755,
        vars: {
            project_name: project_name,
            install_message: install_message,
            gem_dir_version: gem_dir_version
        }
  end

  if %w[pkg dmg].include?(pkg_type)
    plist_path = File.join(install_path, 'td-agent.plist')
    mkdir File.dirname(plist_path)
    erb source: 'td-agent.plist.erb',
        dest: sub_name(plist_path),
        mode: 0o755,
        vars: {
          project_name: project_name,
          install_path: install_path,
          gem_dir_version: gem_dir_version
        }
  else
    initd_file_path = File.join(project.resources_path, 'etc', 'init.d', project.name)
    template_path = File.join('etc', 'init.d', pkg_type, 'td-agent')
    mkdir File.dirname(initd_file_path)
    erb source: template_path,
        dest: sub_name(initd_file_path),
        mode: 0o755,
        vars: {
          project_name: project_name,
          install_path: install_path,
          gem_dir_version: gem_dir_version
        }

    systemd_file_path = File.join(project.resources_path, 'etc', 'systemd', "#{project_name}.service")
    template_path = File.join('etc', 'systemd', 'td-agent.service.erb')
    mkdir File.dirname(systemd_file_path)
    erb source: template_path,
        dest: sub_name(systemd_file_path),
        mode: 0o755,
        vars: {
          project_name: project_name,
          install_path: install_path,
          gem_dir_version: gem_dir_version
        }

    # render commander service file
    systemd_file_path = File.join(project.resources_path, 'etc', 'systemd', "#{commander_name}.service")
    template_path = File.join('etc', 'systemd', "#{commander_name}.service.erb")
    mkdir File.dirname(systemd_file_path)
    erb source: template_path,
        dest: sub_name(systemd_file_path),
        mode: 0o755,
        vars: {
          project_name: project_name,
          install_path: install_path,
          gem_dir_version: gem_dir_version,
          commander_name: commander_name
        }

    ['td-agent.conf', 'td-agent.conf.tmpl', %w[logrotate.d td-agent.logrotate], %w(prelink.conf.d td-agent.conf)].each do |item|
      conf_path = File.join(project.resources_path, 'etc', project_name, *([item].flatten))
      template_path = File.join('etc', 'td-agent', *([item].flatten))
      mkdir File.dirname(conf_path)
      erb source: template_path,
          dest: sub_name(conf_path),
          mode: 0o644,
          vars: {
            project_name: project_name,
            install_path: install_path,
            gem_dir_version: gem_dir_version
          }
    end


    %w[td-agent td-agent-gem].each do |command|
      sbin_path = File.join(install_path, 'usr', 'sbin', command)
      template_path = File.join('usr', 'sbin', "#{command}.erb")
      mkdir File.dirname(sbin_path)
      erb source: template_path,
          dest: sub_name(sbin_path),
          mode: 0o644,
          vars: {
              project_name: project_name,
              install_path: install_path,
              gem_dir_version: gem_dir_version
          }
    end

    delete File.join(install_path, 'etc')
    copy File.join(project.resources_path, 'etc'), install_path
  end
end
