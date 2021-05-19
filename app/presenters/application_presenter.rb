class ApplicationPresenter
  attr_reader :collection

  def initialize
    @collection = ApplicationRecord.none
  end

  private

  def pagination; end
end