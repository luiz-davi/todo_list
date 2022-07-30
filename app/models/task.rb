class Task < ApplicationRecord
  belongs_to :list

  def check_list
    return if self.list.tasks.count == 1 && list.tasks.first.done
    return unless self.done
    return if self.list.tasks.pluck(:done).include?(false)

    list.update!(finished: true)
  end

end
