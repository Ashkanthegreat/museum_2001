class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    exhibits.find_all {|exhibit|
      patron.interests.include?(exhibit.name)}
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    @exhibits.reduce({}) do |exhibit_patrons, exhibit|
      exhibit_patrons[exhibit] = @patrons.find_all do |patron|
        patron.interests.include?(exhibit.name)
      end
      exhibit_patrons
    end
  end

  def ticket_lottery_contestants(exhibit)
    @patrons.select { |patron| patron.interests.include?(exhibit.name) && patron.spending_money < exhibit.cost }
  end

  def draw_lottery_winner(exhibit)
    if ticket_lottery_contestants(exhibit).empty?
      nil
    else
      ticket_lottery_contestants(exhibit).sample.name
    end

  end

  def announce_lottery_winner(exhibit)
    return "No winners for this lottery" if draw_lottery_winner(exhibit) == nil
    return "#{draw_lottery_winner(exhibit)} has won the Dead Sea Scrolls exhibit lottery"

  end


end
