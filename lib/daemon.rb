class Daemon
  DEFAULT_POLL_EVERY = 1.minute

  def initialize(source, endpoint, options = {})
    @source = source
    @endpoint = endpoint
    @poll_every = options[:poll_every]
  end

  def run!
    loop do
      @last_polled_at = Time.now
      Notifier.new(@source, @endpoint, since: @last_polled_at).notify!
      sleep(@poll_every)
    end
  end
end
