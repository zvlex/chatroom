module ApplicationHelper
  def room_odd_table_class(room_id)
    if room_id.odd?
      'pure-table-odd'
    end
  end

  def created_at(datetime)
    datetime.strftime("%d %B %Y %H:%M")
  end
end
