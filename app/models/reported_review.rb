class ReportedReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  after_create :increment_report_count
  after_destroy :decrement_report_count


  private
    def increment_report_count
      self.review.update(report_count: (self.review.report_count.to_i + 1))
    end

    def decrement_report_count
      self.review.update(report_count: (self.review.report_count.to_i - 1))
    end
end
