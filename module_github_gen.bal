import module_github_gen.'remote;
import module_github_gen.issue_remote;
import module_github_gen.issue_resource;
import ballerinax/github;
# Returns the string `Hello` with the input string name.
#
# + name - name as a string
# + return - "Hello, " with the input string name
public function main() returns error? {

    //// Repos
    ConnectionConfig conConfig = {

    };

    // Resource Function
    Client repoClient = check new Client(conConfig);
    MinimalRepository[] repos = check repoClient->/orgs/["ballerina-platform"]/repos();

    // Remote Function
    'remote:Client remoteClient = check new 'remote:Client(conConfig);
    'remote:MinimalRepository[] remoteRepos = check remoteClient->reposListForOrg("ballerina-platform");

    // Github Module
    github:ConnectionConfig githubConConfig = {
        auth: {
            token: ""
        }
    };
    github:Client githubClient = check new github:Client(githubConConfig);
    stream<github:Repository, github:Error?> repositories = check githubClient->getRepositories("ballerina-platform");

    
    //// Issues

    // Resource Function
    issue_resource:Client issueResClient = check new 'issue_resource:Client(conConfig);
    issue_resource:Issue[] issues = check issueResClient->/issues();

    // Remote Function
    issue_remote:Client issueRemoteClient = check new 'issue_remote:Client(conConfig);
    issue_remote:Issue[] remoteIssues = check issueRemoteClient->issuesList();

    stream<github:Issue, github:Error?> issuesResult = check githubClient->getIssues("ballerina-platform", "ballerina-lang", {});


    //// Repo Activities

    // Resource Function
    Activity[] repoActivities = check repoClient->/repos/AzeemMuzammil/DroneSwarm/activity(direction = "asc", activity_type = "push");

    // Remote Function
    'remote:Activity[] remoteRepoActivities = check remoteClient->reposListActivities("AzeemMuzammil", "DroneSwarm", direction = "asc", activity_type = "push");
}
