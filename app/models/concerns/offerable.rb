module Offerable
  extend ActiveSupport::Concern

  included do
    has_one :offer, as: :offerable, touch: true, dependent: :destroy
  end
end
