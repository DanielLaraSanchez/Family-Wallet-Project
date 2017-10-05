require('pg')
class SqlRunner

  def self.run(sql, values)
    begin
      db = PG.connect({ dbname: 'da7g4gr9uhq84l', host: 'ec2-23-21-92-251.compute-1.amazonaws.com', port:
'5432', user: 'wbmythjbxwfbzh', password: '84b57888dc5af37ebfc5c8c70c87c22e17d6118e34b22304912e713d8f513a48'})
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close
    end
    return result
  end

  end
