module ApplicationHelper
  def pretty_filesize(size, unit)
    Filesize.from("#{size} #{unit}").pretty
  end
end
