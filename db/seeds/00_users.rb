users = [
  {
    login: 'max',
    first_name: 'Максим',
    middle_name: 'Александрович',
    last_name: 'Иванович',
    email: 'max@ivanov.dev',
    gender: 'male',
    birth_date: '1995-01-31'
  },
  {
    login: 'mi8',
    first_name: 'Алла',
    middle_name: 'Климовна',
    last_name: 'Миль',
    email: 'alla@mil.dev',
    gender: 'female',
    birth_date: '1997-10-02'
  },
]

users.each do |user_hash|
  User.find_or_create_by!(login: user_hash[:login]) do |user|
    user.attributes = user_hash
  end
end