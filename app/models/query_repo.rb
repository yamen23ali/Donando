class QueryRepo

  def self.demands_query(filter, ids)
    conditions = Array.new
    
    conditions.push( self.ngo_ids_query(ids) ) if !ids.blank?
    
    conditions.push( self.fuzzy_text_query(filter) )

    {
      query: {
        bool:{
          must: conditions
        }
        
      },
      highlight: {  
        pre_tags: ['<em>'],
        post_tags: ['</em>'],
        fields: { 
          data: {}
        }
      }
    }
  end

  private 

  def self.ngo_ids_query(ids)
    {
      terms:{
        ngo_id: ids
      }
    }
  end

  def self.fuzzy_text_query(filter)
    {
      match: {
        data: {
          query: filter,
          fuzziness: 2,
          prefix_length: 1
        }
      }
    }
  end

end
