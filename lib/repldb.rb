require 'cgi'
require 'uri'
require 'json'
require 'net/http'

class Client
  # Change <tt>url</tt> to point to a different path.
  # @param url [String, nil]
  def initialize(url = ENV['REPLIT_DB_URL'])
    @url = url
  end

  # Sets <tt>key</tt> to <tt>val</tt>.
  # @param key [String] the key to set.
  # @param val [Any] the value.
  def set(key, val)
    post_url(@url.to_s, serialize(key) => JSON.generate(val))
  end

  # Gets <tt>key</tt>.
  # If it doesn't exist, <tt>default<tt> will be used.
  # @param key [String] the key to get
  # @param default [Any] the default value if the key doesn't exist.
  def get(key, default = nil)
    val = get_url("#{@url}/#{serialize(key)}")
    if val.body == ''
      default
    else
      begin
        JSON.parse(val.body)
      rescue StandardError
        default
      end
    end
  end

  # Get all the keys as an array.
  # <tt>prefix</tt> can be used to get all keys with a prefix.
  # @param prefix [String, nil] Get all keys with <tt>prefix</tt> at the start.
  def keys(prefix = '')
    get_url("#{@url}?prefix=#{prefix}").body.split("\n").map { |k| deserialize(k) }
  end

  # Deletes <tt>key</tt>.
  # @param key [String]
  def del(key)
    uri = URI.parse("#{@url}/#{serialize(key)}")
    req = Net::HTTP::Delete.new(uri.path)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.request(req)
  end

  # Deletes all keys, ultimately emptying the database.
  def del_all
    keys.each { |k| del(k) }
  end

  # This will append <tt>hash</tt>.
  # **This will NOT replace existing keys!**
  # @param hash [Hash]
  def set_hash(hash)
    if hash.is_a? Hash
      hash.each { |k, v| set(k, v) }
    else
      raise '[GemDb] Error: Argument must be a hash'
    end
  end

  # Gets all the keys as a hash.
  def get_hash
    o = {}
    ks = keys
    ks.each { |k| o[k] = get(k) }
    o
  end

  # Check if <tt>key</tt> exists.
  # @param key [String]
  def exists?(key)
    !get(key).nil?
  end

  # internals
  private def post_url(url, data)
    Net::HTTP.post_form(URI(url), data)
  end

  private def get_url(url)
    Net::HTTP.get_response(URI(url))
  end

  private def serialize(key)
    CGI.escape key.to_s
  end

  private def deserialize(key)
    CGI.unescape key.to_s
  end
end
