ActiveRecord::Base.class_eval do
  def self.reset_autoincrement(options={})
    options[:to] ||= 1
    case self.connection.adapter_name
      when 'MySQL'
        self.connection.execute "ALTER TABLE #{self.table_name} AUTO_INCREMENT=#{options[:to]}"
      when 'PostgreSQL'
        self.connection.execute "ALTER SEQUENCE #{self.table_name}_id_seq RESTART WITH #{options[:to]};"
      when 'SQLite'
        self.connection.execute "UPDATE sqlite_sequence SET seq=#{options[:to]} WHERE name='#{self.table_name}';"
      else
    end
  end
end

def fake_time_from(time_ago = 1.year.ago)
  time_ago+(rand(8770)).hours
end

def fake_number(start = 0, stop = 99, step = 1)
  (start..stop).step(step).sample
end


print 'Drop Users...'
User.unscoped.destroy_all
User.reset_autoincrement
puts 'done.'

print 'Create Users...'
User.create([
  {email: 'admin@example.com', password: 'password'},
  {email: 'test@example.com',  password: 'password'}
])
puts 'done.'

print 'Drop Articles...'
Article.unscoped.destroy_all
Article.reset_autoincrement
puts 'done.'

print 'Create Articles...'
55.times do
  Article.create!(
      title:   Faker::Lorem.sentence(15),
      content: Faker::Lorem.paragraph(100),
      user_id: [2,3].sample
  )
end
puts 'done.'