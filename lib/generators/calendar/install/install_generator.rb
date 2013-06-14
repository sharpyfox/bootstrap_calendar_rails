module Calendar
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    desc "This generator creates an initializer file at config/initializers"
    argument :stylesheets_type, :type => :string, :default => 'less', :banner => '*less or static'

    def add_assets

      css_manifest = 'app/assets/stylesheets/application.css'

      if File.exist?(css_manifest)
        # Add our own require:
        content = File.read(css_manifest)
        if content.match(/require_calendar\s+\.\s*$/)
          # Good enough - that'll include our calendar.css.less
        else
          style_require_block = " *= require_calendar\n"
          insert_into_file css_manifest, style_require_block, :after => "require_self\n"
        end
      else
        copy_file "application.css", "app/assets/stylesheets/application.css"
      end

      # styles
      if use_less?
        copy_file "calendar.css.less", "app/assets/stylesheets/calendar.css.less"
        copy_file "events.css.less", "app/assets/stylesheets/events.css.less"
        copy_file "grid.css.less", "app/assets/stylesheets/grid.css.less"
        copy_file "month.css.less", "app/assets/stylesheets/month.css.less"
        copy_file "theme.css.less", "app/assets/stylesheets/theme.css.less"
        copy_file "variables.css.less", "app/assets/stylesheets/variables.css.less"
        copy_file "week.css.less", "app/assets/stylesheets/week.css.less"
      else
        copy_file "calendar.css", "app/assets/stylesheets/calendar.css"
      end
    end

    def add_locale
      if File.exist?("config/locales/en.calendar.yml")
        localez = File.read(File.expand_path('../templates', __FILE__) + "/en.calendar.yml")
        insert_into_file "config/locales/en.calendar.yml", localez, :after => "en\n"
      else
        copy_file "en.calendar.yml", "config/locales/en.calendar.yml"
      end
    end

    private
      def use_less?
        (defined?(Less) && (stylesheets_type!='static') ) || (stylesheets_type=='less')
      end    
  end
end
