#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;

#define MAX_FRAMES 3 // Number of frames

// Function to check if a page is already in memory
int isPageInMemory(int frames[], int numFrames, int page) {
for (int i = 0; i &lt; numFrames; i++) {
if (frames[i] == page) {
return i; // Return index if page is found
}
}
return -1; // Page not found
}

// FIFO Page Replacement Algorithm
void fifo(int pages[], int numPages, int numFrames) {
int frames[MAX_FRAMES] = {-1, -1, -1}; // Initialize frames
int front = 0, pageFaults = 0;

printf(&quot;\nFIFO Page Replacement\n&quot;);
for (int i = 0; i &lt; numPages; i++) {
int page = pages[i];

if (isPageInMemory(frames, numFrames, page) == -1) { // Page Fault
frames[front] = page; // Replace the oldest page
front = (front + 1) % numFrames;
pageFaults++;
}

// Print current frame status

printf(&quot;Step %d: &quot;, i + 1);
for (int j = 0; j &lt; numFrames; j++) {
if (frames[j] == -1) printf(&quot;- &quot;);
else printf(&quot;%d &quot;, frames[j]);
}
printf(&quot;\n&quot;);
}

printf(&quot;Total Page Faults: %d\n&quot;, pageFaults);
}

// LRU Page Replacement Algorithm
void lru(int pages[], int numPages, int numFrames) {
int frames[MAX_FRAMES] = {-1, -1, -1}; // Initialize frames
int recent[MAX_FRAMES] = {0}; // Track recency of usage
int pageFaults = 0;

printf(&quot;\nLRU Page Replacement\n&quot;);
for (int i = 0; i &lt; numPages; i++) {
int page = pages[i];
int index = isPageInMemory(frames, numFrames, page);

if (index == -1) { // Page Fault
int lruIdx = 0;
for (int j = 1; j &lt; numFrames; j++) {
if (recent[j] &lt; recent[lruIdx]) {
lruIdx = j;
}
}
frames[lruIdx] = page;
pageFaults++;

} else {
recent[index] = i; // Update recency
}

for (int j = 0; j &lt; numFrames; j++) recent[j]++; // Increase recency
recent[isPageInMemory(frames, numFrames, page)] = 0; // Reset used page

// Print frame status
printf(&quot;Step %d: &quot;, i + 1);
for (int j = 0; j &lt; numFrames; j++) {
if (frames[j] == -1) printf(&quot;- &quot;);
else printf(&quot;%d &quot;, frames[j]);
}
printf(&quot;\n&quot;);
}

printf(&quot;Total Page Faults: %d\n&quot;, pageFaults);
}

// LFU Page Replacement Algorithm
void lfu(int pages[], int numPages, int numFrames) {
int frames[MAX_FRAMES] = {-1, -1, -1}; // Initialize frames
int frequency[MAX_FRAMES] = {0}; // Track usage frequency
int pageFaults = 0;

printf(&quot;\nLFU Page Replacement\n&quot;);
for (int i = 0; i &lt; numPages; i++) {
int page = pages[i];
int index = isPageInMemory(frames, numFrames, page);

if (index == -1) { // Page Fault

int lfuIdx = 0;
for (int j = 1; j &lt; numFrames; j++) {
if (frequency[j] &lt; frequency[lfuIdx]) {
lfuIdx = j;
}
}
frames[lfuIdx] = page;
frequency[lfuIdx] = 1;
pageFaults++;
} else {
frequency[index]++; // Increase frequency
}

// Print frame status
printf(&quot;Step %d: &quot;, i + 1);
for (int j = 0; j &lt; numFrames; j++) {
if (frames[j] == -1) printf(&quot;- &quot;);
else printf(&quot;%d &quot;, frames[j]);
}
printf(&quot;\n&quot;);
}

printf(&quot;Total Page Faults: %d\n&quot;, pageFaults);
}

// Main function
int main() {
int choice, numPages;
int pages[] = {1, 2, 3, 2, 1, 4, 5, 2, 1, 3, 6}; // Sample reference string
numPages = sizeof(pages) / sizeof(pages[0]);

while (1) {
printf(&quot;\nPage Replacement Algorithms:\n&quot;);
printf(&quot;1. FIFO\n&quot;);
printf(&quot;2. LRU\n&quot;);
printf(&quot;3. LFU\n&quot;);
printf(&quot;4. Exit\n&quot;);
printf(&quot;Enter your choice: &quot;);
scanf(&quot;%d&quot;, &amp;choice);

if (choice == 4) break; // Exit

switch (choice) {
case 1:
fifo(pages, numPages, MAX_FRAMES);
break;
case 2:
lru(pages, numPages, MAX_FRAMES);
break;
case 3:
lfu(pages, numPages, MAX_FRAMES);
break;
default:
printf(&quot;Invalid choice! Please select a valid option.\n&quot;);
}
}

return 0;
}