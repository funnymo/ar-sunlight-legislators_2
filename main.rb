require_relative 'db/config'
require_relative 'app/models/representative'
require_relative 'app/models/legislator'
require_relative 'app/models/senator'
require_relative 'app/models/state'
#--------------------------------------------
#Given any state, first print out the senators for that state (sorted by last name), then print out the representatives (also sorted by last name). Include the party affiliation next to the name. The output might look something like this:

def list_rep_state(z)
  puts "Representatives (in state #{z}):"
  rep = Representative.where("state = ? AND title =?", z, "Rep").order(:lastname)
  rep.each do |x|
    puts "#{x.firstname} #{x.lastname} -- #{x.party}"
  end
end

def list_sen_state(z)
  puts "Senators (in state #{z}):"
  sen = Senator.where("state=? AND title=?", z,"Sen").order(:lastname)
  sen.each do|x|
    puts "#{x.firstname} #{x.lastname} -- #{x.party}"
  end    
end

def list_rep_party(z)
  puts "Representatives (in party #{z}):"
  rep = Representative.where("party=? AND title=?", z,"Rep").order(:lastname)
  rep.each do |x|
    puts "#{x.firstname} #{x.lastname} -- #{x.party}"
  end
end

def list_sen_party(z)
  puts "Senators (in party #{z}):"
  sen = Senator.where("party=? AND title=?", z,"Sen").order(:lastname)
  sen.each do |x|
    puts "#{x.firstname} #{x.lastname} -- #{x.party}"
  end
end

# list_sen_state("CA")
# list_rep_state("CA")
# list_sen_party("D")
# list_rep_party("D")

#------------------------------------------
# Given a gender, print out what number and percentage of the senators are of that gender as well as what number and percentage of the representatives, being sure to include only those congresspeople who are actively in office, e.g.:

def calc_sen_male
  a = Senator.where("title = ?","Sen")
  allsenator = a.count

  a = Senator.where("gender = ? AND title = ?", "M", "Sen")
  malesenator = a.count

  percentage = ((malesenator.to_f/ allsenator.to_f)*100).to_i
  puts "Male Senators:" + " "+ percentage.to_s + "%"
end

def calc_rep_male
  a = Representative.where("title = ?","Rep")
  allrep = a.count

  a = Representative.where("gender = ? AND title = ?", "M", "Rep")
  malerep = a.count

  percentage = ((malerep.to_f/ allrep.to_f)*100).to_i
  puts "Male Reps:" + " "+ percentage.to_s+ "%"
end

# calc_sen_male
# calc_rep_male

#------------------------------------------

#Print out the list of states along with how many active senators and representatives are in each, in descending order (i.e., print out states with the most congresspeople first).

def calc_sen2
  #Normal level
  states = Legislator.uniq.pluck(:state)
  # Ordering the states begin----------------
  array_of_count = []

  states.each do |state|
    array_of_count << [state, Legislator.where(state: state).count]
  end

  states = array_of_count.sort{|a,b| b[1] <=> a [1]}
  states.map!{|state| state[0]} #---> to get just the states--> ["HI","TX",etc]
  # Ordering states end---------------------------

  #God Level
  # states.map!{|state| [state, Legislator.where(state: state).count]}
  # states = Legislator.group(:state).count.sort{|a,b| b[1] <=> a[1]}.map(&:first)
  # states = Legislator.group(:state).order('count_state DESC').count('state')

  states.each do |state|
    puts "#{state}: #{ Legislator.where(title: "Sen", state: state).count}"+ " Sen" +  " #{ Legislator.where(title: "Rep", state: state).count }" + " Rep"
  end

end


# calc_sen2


#------------------------------------------

#For Senators and Representatives, count the total number of each (regardless of whether or not they are actively in office).

def bla
a = Senator.where("title = ?", "Sen")
b = Representative.where("title = ?", "Rep")
p "Senators: #{a.count}"
p "Representatives: #{b.count}"
end

# bla

#------------------------------------------
#Now use ActiveRecord to delete from your database any congresspeople who are not actively in office, then re-run your count to make sure that those rows were deleted.

def del
  a = Senator.where("in_office = ? AND title =?", false ,'Sen').destroy_all
    b = Representative.where("in_office = ? AND title =?", false,'Rep').destroy_all
#check if deleted
  c = Senator.where("title = ?",'Sen')
  d = Representative.where("title = ?",'Rep')
p "Senators: #{c.count}"
p "Representatives: #{d.count}"

end

# del


#--------------------------------------