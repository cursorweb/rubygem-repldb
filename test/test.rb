require 'lib/repldb'

class AssertionError < RuntimeError
end

def assert
  raise AssertionError unless yield
end

class TestDb
  def initialize; end

  def set_bool
    db = Client.new
    db.set('bool_val', true)
    assert { db.get('bool_val') == true }
    db.del_all
  end

  def set_str
    db = Client.new
    db.set('str_val', 's')
    assert { db.get('str_val') == 's' }
    db.del_all
  end

  def set_int
    db = Client.new
    db.set('int_val', 5)
    assert { db.get('int_val') == 5 }
    db.del_all
  end

  def del
    db = Client.new
    db.set('del_val', 3)
    db.del('del_val')
    assert { db.exists?('del_val') == false }
  end

  def hash
    db = Client.new
    db.set('key', 3)
    db.set('test', 4)
    assert { db.get_hash == { 'key' => 3, 'test' => 4 } }
    db.del_all
  end
end

a = TestDb.new
a.set_bool
a.set_int
a.set_str
a.del
a.hash

puts "Tests successful!"
