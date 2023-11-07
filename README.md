https://www.gradio.app/guides/real-time-speech-recognition
https://www.gradio.app/guides/quickstart
https://huggingface.co/openai/whisper-base.en
https://huggingface.co/openai/whisper-base.en

## **Overview**

The "English Learner" is a mobile application aimed at helping users improve their English skills, focusing particularly on preparation for the CELPIP test. The application uniquely generates English descriptions from uploaded images in both text and voice formats, aiding users in better understanding and articulating their environment.

### **Core Features:**

1. **Text-to-Speech**: As already implemented.

2. **User Authentication**: Firebase.
https://github.com/lemonshark05/ImgTalk/assets/100770743/193e1366-44fa-4d30-864d-8074098b8203

3. **Vocabulary Book with Pronunciation Check**: 

4. **Study Groups**: Users can create or join study groups. Within these groups, they can share vocabulary lists, quiz each other, or share resources for the CELPIP test. This can be done through the Firebase Realtime Database.

5. **Mistake Tracking and Rewatch**: Record user mistakes in pronunciation or vocabulary tests and store them in Firebase. Users can revisit these mistakes, and perhaps even receive targeted practice questions based on their past errors.

### **Web Development Focus:**

- **User Dashboard**: A web-based dashboard where users can visualize their progress, and join study groups.
- **Quiz Creator**: A feature that lets users or study groups create their own quizzes, which they can share within their groups or publicly.

## **Languages & Tools**

- **Language**: Swift 5
- **Architecture**: MVVM (Model-View-ViewModel)
- **Frameworks/Tools**: Huggingface (for dataset/API), Firebase (for authentication), Apple's Speech Framework (for voice recognition), Firebase Realtime Database (for history and scoring).

---

## **Upcoming Milestones**

### **11/06 Milestone #2**

- Implement core functionality of generating English descriptions from images.
- Begin development of Vocabulary Book with Pronunciation Check feature.
- (If time allows) Start initial work on the Instant Messaging feature.
