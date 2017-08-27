require('pg')
# require_relative('./transactions')
require_relative('../db/sql_runner')



class Tag

attr_accessor(:type, :color)
attr_reader(:id)

def initialize ( tag )
@id = tag['id'].to_i() if tag['id'].to_i()
@type = tag['type']
@color = tag['color']

end


  def save()
    sql = ' INSERT INTO tags
    (type, color)
    VALUES ($1, $2)
    RETURNING *;'
    values = [@type, @color]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data.first['id'].to_i()
  end

  def self.all()
    sql = ' SELECT * FROM tags;'
    values = []
    tag_data = SqlRunner.run(sql, values)
    result = tag_data.map { |tag| Tag.new(tag)}
    return result
  end

  def self.find(id)
    sql = 'SELECT * FROM tags WHERE id = $1'
    values = [id]
    account_data = SqlRunner.run(sql, values)
    result = Tag.new(account_data.first)
  end


  def delete()
    sql = ' DELETE FROM tags WHERE id = $1'
    values = [@id]
    tag_data = SqlRunner.run(sql, values)
  end

  def update()
    sql= 'UPDATE  tags SET (type, color)
    = ($1, $2) WHERE id = $3'
    values = [@type, @color, @id]
    SqlRunner.run(sql, values)
  end











end
