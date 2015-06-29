# Author::    Nikita Vasiliev  (mailto:sharpyfox@gmail.com)
# Encoding::  utf-8
# License::   Distributes under the same terms as Ruby

# Helper for the calendar building
module BootstrapCalendarRails
  module ViewHelpers
    def bootstrap_calendar(date = Date.today, options = {}, &block)
      BootstrapCalendar.new(self, date, options, block).build
    end

    class BootstrapCalendar
      DAY_NAMES = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
      MOBILE_DAY_NAMES = %w[Sun Mon Tues Wed Thur Fri Sat]

      delegate :content_tag, to: :view
      attr_reader :view, :date, :callback, :options

      # build calendar
      def build
        result = content_tag :div, class: 'cal-month-box' do
          week_rows
        end
        header << result
      end

      # you can pass some extra options in "options" parameter
      def initialize(view, date, options = {}, callback)
        @view = view
        @date = date
        @options = options.symbolize_keys
        @callback = callback
      end

      protected
        # build one week
        def build_week(week)
          content_tag :div, class: "cal-row-fluid" do
            week.map { |day| day_cell(day) }.join.html_safe
          end
        end

        # build one day cell
        def day_cell(day)
          content_tag :div, class: "cal-span1 cal-cell" do
            content_tag :div, class: day_classes(day) do
              view.capture(day, &callback)
            end
          end
        end

        # collect classes for day cell
        def day_classes(day)
          classes = ["cal-month-day"]
          classes << "cal-day-today" if day == Date.today
          classes << "cal-day-outmonth cal-month-first-row" if day.month != date.month
          classes << "cal-day-inmonth" if day.month == date.month
          classes << "cal-day-weekend" if day.saturday? || day.sunday?

          options[:extra_day_classes].call(classes, day) unless options[:extra_day_classes].nil?
          classes.join(" ") unless classes.empty?
        end

        # return day names resorted form start_day
        def day_names
          get_day_names(DAY_NAMES)
        end

        # return day names for mobile resorted form start_day
        def mobile_day_names
          get_day_names(MOBILE_DAY_NAMES)
        end

        # return header, which contains both desktop and mobile day names
        def header
          content_tag 'div', class: "cal-row-fluid cal-row-head" do
            build_header(day_names, "cal-span1 hidden-xs") +
            build_header(mobile_day_names, "cal-span1 visible-xs")
          end
        end

        # return start day, provided by start_day option
        # it's :monday by default
        def start_day
          if options[:start_day] && DAY_NAMES.include?(options[:start_day].to_s.humanize)
            @start_day ||= options[:start_day].to_s.downcase.to_sym
          else
            @start_day ||= :monday
          end
        end

        # return start day index in DAY_NAMES array
        def start_day_index
          @start_day_index ||= DAY_NAMES.index { |n| n.downcase == start_day.to_s } || 0
        end

        # build week rows
        def week_rows
          weeks.map { |week| build_week(week) }.join.html_safe
        end

        # return weeks of month
        def weeks
          first = date.beginning_of_month.beginning_of_week(start_day)
          last = date.end_of_month.end_of_week(start_day)
          (first..last).to_a.in_groups_of(7)
        end

      private
        # common for modile and desktop days function
        def build_header(days_array, classes)
          days_array.map do |day|
            content_tag :div, class: classes do
              I18n.translate day
            end
          end.join.html_safe
        end

        # common for modile and desktop days function
        # resort days using start day index
        def get_day_names(days_array)
          return days_array if start_day_index.zero?
          days_array[start_day_index, days_array.size - start_day_index] +
              days_array[0, start_day_index]
        end
    end
  end
end
