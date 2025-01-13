# code-with-quarkus

This project uses Quarkus, the Supersonic Subatomic Java Framework.

If you want to learn more about Quarkus, please visit its website: <https://quarkus.io/>.

# All verification steps below are taken in whole seconds

# Verification steps for slow running tests on Windows 11 (3.17.6)
1. Do "./gradlew clean build" (Will ensure all dependencies are downloaded)
2. Do "./gradlew clean" 
3. Do "./gradlew build" again and record the time it takes.
4. Do "./gradlew build" again and record the time it takes.
5. Run the test GreetingResourceTest from your IDE (IntelliJ), and record the "Build and Run execution times"
6. Make a change i the System.out.println line and run the test again, and record the "Build and Run execution times"

# Verification steps for slow running tests on Windows 11 (999-SNAPSHOT)
1. Do "./gradlew clean build" (Will ensure all dependencies are downloaded)
2. Do "./gradlew clean"
3. Do "./gradlew build" again and record the time it takes.
4. Do "./gradlew build" again and record the time it takes.
5. Run the test GreetingResourceTest from your IDE (IntelliJ), and record the "Build and Run execution times"
6. Make a change i the System.out.println line and run the test again, and record the "Build and Run execution times"
7. Run the test again, WITHOUT any changes, and record the "Build and Run execution times"

# Results

## Intel(R) Core(TM) i9-10850K CPU @ 3.60GHz   3.60 GHz with nvme m.2 disk
### 3.17.6
3. 34 seconds
4. 5 second
5. Build 9 seconds / Run 1 second
6. Build 9 seconds / Run 1 second
7. Build 9 seconds / Run 1 second
8. 
### 999-SNAPSHOT (130125)
3. 32 seconds
4. 1 second
5. Build 8 seconds / Run 1 second
6. Build 8 seconds / Run 1 second
7. Build 8 seconds / Run 1 second