args = commandArgs(trailingOnly = TRUE);
if (length(args) >= 1) {
  file = args[1];
} else {
  file = "C:/Users/Marc/framestats.txt";
}

data = read.table(file=file, comment.char=';');
regions = unique(data[,1])

num_regions = length(regions);
num_frames  = length(data[,1]) / num_regions;

# If the number of regions is greater than 1, then what we have is a series
# of samples. Compute total frame time if this is the case.
frame_times <- c();
if (num_frames > 1) {
  for (i in 1:num_frames) {
    frame = data[i:(i+num_regions-1),];
    total = sum(frame[,2]);
    frame_times <- c(frame_times, total);
  }
}

# plot
if (length(args) >= 1) {
  output = paste0(file, ".pdf");
  cat(paste("Saving output to:", output, "\n"));
  pdf(output);
}
plot(x=data, type='l', xlab="Region", ylab="Time (ms)", main="Region Time")
plot(frame_times, type='l', col='blue', xlab="Frame", ylab="Time (ms)", main="Frame Time");
if (length(args) >= 1) {
  dummy <- dev.off(); # supress "null device" output
}

cat(paste("regions:", num_regions, "\n"));
cat(paste("frames:", num_frames, "\n"));

cat("Data:\n");
print(summary(data));

if (num_frames > 1) {
  cat("Frame time:\n");
  print(summary(frame_times));
}

# per-region summaries
for (i in 1:num_regions) {
  region = regions[i];
  values = data[data[,1] == region,2];
  cat(paste0(region, ":\n"));
  print(summary(values));
}

#data = as.matrix(read.table(file="C:/Users/Marc/framestats.txt", comment.char=';'))
#first = T;
#for (name in unique(data[,1])) {
#  entries = data[data[,1] == name,];
#  values  = entries[,2];
#  if (first) {
#    plot(values, type='l', ylim=c(0,80));
#    first = F;
#  }
#  else {
#    lines(values, type='l');
#  }
#}
