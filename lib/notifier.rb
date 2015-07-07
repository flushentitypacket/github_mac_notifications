class Notifier
  def initialize(source, endpoint)
    @source = source
    @endpoint = endpoint
  end

  def notify!(options = {})
    notifications_since(options[:from]).each do |notification|
      message = notification.subject.title
      title = 'Github'
      subtitle = notification.subject.type
      link = 'https://github.com/notifications'

      @endpoint.notify(message, title: title, subtitle: subtitle, open: link)
    end
  end

  def notifications_since(t = Time.at(0))
    # `@source.notifications` gives unread only by default
    @source.notifications(since: t)
  end
end
