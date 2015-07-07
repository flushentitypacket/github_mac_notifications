require 'delegate'
require 'yaml'

class Client < Delegator
  def self.from_yml(path_to_yml)
    from_hash(YAML.load_file(path_to_yml)['github'])
  end

  def self.from_hash(h)
    client = Octokit::Client.new(
        login: h['login'] || h[:login],
        password: h['password'] || h[:password])
    new(client)
  end

  def initialize(client)
    super
    @client = client
  end

  def __getobj__
    @client
  end

  def __setobj__(obj)
    @client = obj
  end
end
