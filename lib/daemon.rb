require 'logger'

class Daemon
  DEFAULT_POLL_EVERY = 60
  DEFAULT_LOGGER = Logger.new(STDOUT)

  def initialize(source, endpoint, options = {})
    @source = source
    @endpoint = endpoint
    @poll_every = options[:poll_every] || DEFAULT_POLL_EVERY
    @logger = options[:logger] || DEFAULT_LOGGER
  end

  def run!
    loop do
      begin
        @last_polled_at = Time.now
        Notifier.new(@source, @endpoint).notify!(since: @last_polled_at)
        @logger.info("Polled at #{@last_polled_at}")
        sleep(@poll_every)
      rescue => e
        @logger.error("#{e.class}: #{e.message}\n#{e.backtrace}")
      end
    end
  end
end
