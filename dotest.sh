
echo "Doing initial build to ensure dependencies are available"
#read -n1 -r -p "Press any key" key
export JAVA_HOME=/c/jdk21
./gradlew clean build
./gradlew clean
echo "Running build from start"
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
