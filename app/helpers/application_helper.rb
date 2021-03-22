module ApplicationHelper

  def rounded_number(number, multiplicator)
    (number * multiplicator ).to_s.match?(/\d+.0\z/) ? (number * multiplicator).to_i : (number * multiplicator)
  end

end
