require "assistly"
require "builder"

class Pivotal

  attr_reader :requestor

  def initialize(requestor)
    @requestor = requestor
  end

  def cases_to_xml(cases)
    buffer = ""

    xml = Builder::XmlMarkup.new(:target => buffer, :indent => 2)

    xml.instruct!

    xml.external_stories(:type => "array") do
      cases.reverse.each do |kase|
        interactions = Assistly.interactions(:case_id => kase.case.id).results
        interactions = interactions.select { |i| i.interaction.direction == "in" }
        interactions.each do |i|
          interaction = i.interaction
          xml.external_story do
            xml.external_id interaction.case_id
            xml.name interaction.interactionable.email.subject
            xml.description interaction.interactionable.email.body
            xml.requested_by requestor
            xml.created_at({ :type => "datetime" }, interaction.created_at)
            xml.story_type "bug"
            xml.estimate nil
          end
        end
      end
    end

    buffer
  end

end