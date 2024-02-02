These variables are used to get dynamic info about jenkins & Jenkins pipelines
```
BUILD_NUMBER: The current build number, such as "153".
BUILD_ID: The current build ID, a timestamp in the format "yyyy-MM-dd_hh-mm-ss".
BUILD_URL: The URL where the results of this build can be found.
WORKSPACE: The absolute path of the workspace.
JOB_NAME: The name of the project of this build.
JOB_BASE_NAME: The name of the project of this build, stripping off folder paths.
BUILD_TAG: String of "jenkins-${JOB_NAME}-${BUILD_NUMBER}". Convenient to put into a resource file, a jar file, etc for easier identification.
EXECUTOR_NUMBER: A unique number identifying the executor, useful for running multiple builds on the same node simultaneously.
NODE_NAME: The name of the node where the build is running.
NODE_LABELS: Whitespace-separated list of labels that the node is assigned.
JENKINS_HOME: The absolute path of the Jenkins home directory.
JENKINS_URL: The URL of the Jenkins server.
BUILD_DISPLAY_NAME: The display name of the build.
BUILD_DESCRIPTION: The description of the build.
BUILD_USER_ID: The user ID of the user who started the build.
BUILD_USER: The user name of the user who started the build.
BUILD_USER_EMAIL: The email address of the user who started the build.
SVN_REVISION: For Subversion-based projects, this variable contains the revision number.
GIT_COMMIT: For Git-based projects, this variable contains the Git commit hash.
GIT_BRANCH: For Git-based projects, this variable contains the Git branch.
```

```
JOB_NAME: Name of the Jenkins project the pipeline belongs to.
BUILD_NUMBER: Unique identifier for the specific pipeline run within the project.
BUILD_ID: Unique identifier for the specific pipeline run in Jenkins internal format. (Jenkins 2.244+)
BUILD_DISPLAY_NAME: Name of the current build with potential stage information. (Jenkins 2.164+)
BUILD_TAG: String of "jenkins-JOB 
N
​
 AME−{BUILD_NUMBER}".
PREVIOUS_SUCCESSFUL_BUILD: Build number of the most recent successful build for the same job. (Jenkins 1.574+)
PREVIOUS_UNSUCCESSFUL_BUILD: Build number of the most recent unsuccessful build for the same job. (Jenkins 1.574+)
CHANGE_LOG: List of changes that triggered the pipeline run. (Jenkins 2.190+)
GIT_COMMIT: Git commit hash for the build (if triggered from a Git repository).
System-related:

JENKINS_URL: Base URL of the Jenkins server.
JENKINS_HOME: Absolute path to the Jenkins home directory.
NODE_NAME: Name of the Jenkins node where the pipeline is executing.
EXECUTOR_NUMBER: Executor number assigned to the pipeline run on the node.
MASTER_HOST: Hostname of the Jenkins master node. (deprecated)
SLAVE_HOST: Hostname of the Jenkins slave node where the pipeline is running. (deprecated)
NODE_LABELS: Comma-separated list of labels assigned to the node.
JENKINS_NODE_COOKIE: Unique identifier for the Jenkins node instance.
Pipeline-execution related:

STAGE_NAME: Name of the currently executing stage within the pipeline.
CURRENT_STEP_NAME: Name of the currently executing step within the stage.
CURRENT_BUILD: Object representing the current pipeline build.
ENV: Map containing all environment variables defined in the pipeline or through plugins.
ARGS: List of arguments passed to the pipeline (only available if triggered with parameters).
Workspace and files:

WORKSPACE: Absolute path to the directory where the pipeline workspace is located.
JENKINS_WORKSPACE: Alias for WORKSPACE.
JENKINS_BUILD_ARTIFACTS: Path to the directory where pipeline artifacts are published.
PWD: Current working directory within the workspace (usually the same as WORKSPACE).
Tool-specific:

DOCKER_IMAGE_NAME: Docker image name used for the build, if applicable.
GIT_BRANCH: Git branch name for the build, if triggered from a Git repository.
Additional variables might be set by specific tools and plugins used within the pipeline.
```
