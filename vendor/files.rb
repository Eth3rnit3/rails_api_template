def copy_files!
  copy_rubocop_config!
end

private

def copy_rubocop_config!
  copy_file '.rubocop.yml'
end

