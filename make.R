
# This does everything.
drake::r_make()

# Remove the empty, left-over, ggsave()-created plot
file.remove('Rplot001.jpg')