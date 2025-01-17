fullBuildResults=(0,0,0,0,0)
singleTestResults=(0,0,0,0,0)
singleTestResultsSecond=(0,0,0,0,0)
singleTestResultsChanged=(0,0,0,0,0)
tempResult=0
index=0

function getGradleCommandResult {
  gradleCommands=$1
  start_time=$(date +%s)
  ./gradlew $gradleCommands >/dev/null
  end_time=$(date +%s)
  time_fullbuild="$((end_time - start_time))"
  tempResult=$time_fullbuild
}

function doChangedTestCommand {
  sed -i  's/Hello4/Hello5/g' ./src/test/java/org/acme/GreetingResourceTest.java
  getGradleCommandResult $1
  sed -i  's/Hello5/Hello4/g' ./src/test/java/org/acme/GreetingResourceTest.java
}

function doTestRun {
  getGradleCommandResult "clean"
  #Ignore tempResult
  local index=$1
  getGradleCommandResult "build"
  fullBuildResults[index]=$tempResult
  getGradleCommandResult "test --tests org.acme.GreetingResourceTest"
  singleTestResults[index]=$tempResult
  getGradleCommandResult "test --tests org.acme.GreetingResourceTest"
  singleTestResultsSecond[index]=$tempResult
  doChangedTestCommand  "test --tests org.acme.GreetingResourceTest"
  singleTestResultsChanged[index]=$tempResult
}

echo "Doing initial build to ensure dependencies are available"
#read -n1 -r -p "Press any key" key
export JAVA_HOME=/c/jdk21
./gradlew clean build
echo "Running performance monitoring"
doTestRun 0
doTestRun 1
doTestRun 2
doTestRun 3
doTestRun 4

echo ""
echo ""
echo ""

for i in $(seq 0 4);
do
  echo "${fullBuildResults[i]},${singleTestResults[i]},${singleTestResultsSecond[i]},${singleTestResultsChanged[i]}"
done

echo "**************************************************"
echo "Please record the results"
echo "**************************************************"
read -n1 -r -p "Press any key" key

exit;
start_time=$(date +%s)
./gradlew build
end_time=$(date +%s)
time_fullbuild="$((end_time - start_time))"
echo "Running single test file"
start_time=$(date +%s)
./gradlew test --tests org.acme.GreetingResourceTest
end_time=$(date +%s)
time_singletest="$((end_time - start_time))"
echo "Running single test file second time"
start_time=$(date +%s)
./gradlew test --tests org.acme.GreetingResourceTest
end_time=$(date +%s)
time_singletest_nochanges="$((end_time - start_time))"

sed -i  's/Hello4/Hello5/g' ./src/test/java/org/acme/GreetingResourceTest.java
start_time=$(date +%s)
./gradlew test --tests org.acme.GreetingResourceTest
end_time=$(date +%s)
time_singletest_changes="$((end_time - start_time))"
sed -i  's/Hello5/Hello4/g' ./src/test/java/org/acme/GreetingResourceTest.java

echo "**************************************************"
echo "Running build from start took $time_fullbuild seconds to execute."
echo "Running single test file took $time_singletest"
echo "Running single test file second time took $time_singletest_nochanges"
echo "Running single test file with changes took $time_singletest_changes"
echo "**************************************************"
echo "Please record the results"
read -n1 -r -p "Press any key" key

