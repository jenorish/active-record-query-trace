require 'active_support/log_subscriber'
module ActiveRecordQueryTrace

  class << self
    attr_accessor :enabled
    attr_accessor :level
    attr_accessor :lines
    attr_accessor :new_log
    attr_accessor :daywise
  end

  module ActiveRecord
    class LogSubscriber < ActiveSupport::LogSubscriber

      def initialize
        super
        ActiveRecordQueryTrace.enabled = false
        ActiveRecordQueryTrace.level = :app
        ActiveRecordQueryTrace.lines = 5
        ActiveRecordQueryTrace.new_log = true
        ActiveRecordQueryTrace.daywise = false

      end

      def sql(event)
        logname = ActiveRecordQueryTrace.daywise ? "query-log-on-#{Time.now.strftime('%d-%m-%Y')}"  : "query"
        if ActiveRecordQueryTrace.enabled
          index = begin
            if ActiveRecordQueryTrace.lines == 0
              0..-1
            else
              0..(ActiveRecordQueryTrace.lines - 1)
            end
          end

         if ActiveRecordQueryTrace.new_log
             new_logger = Logger.new("#{Rails.root}/log/#{logname}.log")
             logging_info=[]
             logging_info << (color('Called from: ', MAGENTA, true) + clean_trace(caller)[index].join("\n "))
             logging_info << (color('Time: ', GREEN, true) + color(event.time.to_datetime.strftime('%a %b %d %Y %H:%M:%S %Z'),YELLOW,true))
             logging_info << (color('Query: ', BLUE, true) + color(event.payload[:sql],RED,true))
             logging_info << "********************************************************************************\n"
             new_logger.debug(logging_info.join("\n"))
          else
            debug(color('Called from: ', MAGENTA, true) + clean_trace(caller)[index].join("\n "))
         end
        end
      end

      def clean_trace(trace)
        case ActiveRecordQueryTrace.level
        when :full
          trace
        when :rails
          Rails.respond_to?(:backtrace_cleaner) ? Rails.backtrace_cleaner.clean(trace) : trace
        when :app
          Rails.backtrace_cleaner.add_silencer { |line| not line =~ /^app/ }
          Rails.backtrace_cleaner.clean(trace)
        end
      end

      attach_to :active_record
    end
  end
end
