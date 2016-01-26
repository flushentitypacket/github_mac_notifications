class Notifier
  def initialize(source, endpoint)
    @source = source
    @endpoint = endpoint
  end

  def notify!(options = {})
    notifications_since(options[:since]).each do |notification|
      message = notification.subject.title
      title = 'Github'
      subtitle = notification.subject.type
      link = html_url_from_api_url(notification.subject.url)

      @endpoint.notify(message, title: title, subtitle: subtitle, open: link)
    end
  end

  private

  def notifications_since(t = Time.at(0))
    # `@source.notifications` gives unread only by default
    @source.notifications(since: t)
  end

  def html_url_from_api_url(api_url)
    uri = URI.parse(api_url)
    # format: "/repos/PROJECT/REPO/pulls/123"
    uri.path = uri.path.split('/').
      tap { |a| a[4].gsub!('pulls', 'pull'); a.slice!(1) }.join('/')
    uri.host = 'github.com'
    uri.to_s
  end
end
