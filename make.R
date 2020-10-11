
# This does everything.
drake::r_make()

# Remove the empty, left-over, ggsave()-created plot
if (file.exists('Rplot001.jpg')) file.remove('Rplot001.jpg')
