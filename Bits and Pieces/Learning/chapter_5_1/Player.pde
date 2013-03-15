class Player{
  String firstName;
  String lastName;
  String displayName;
  String position;
  String teamName;
  String teamCallSign;
  int ffOverallRank;
  int ffPositionRank;
  int salaryRank;
  int salary;
  
  Player(XML ffNode,String[] salaryNode) {
    String[] nameSplit = ffNode.getString("Name").split(" ");
    
    firstName = nameSplit[0];
    lastName = nameSplit[1];
    displayName = ffNode.getString("Name");
    position = ffNode.getString("Position");
    teamName = salaryNode[4];
    teamCallSign = ffNode.getString("Team");
    ffOverallRank = ffNode.getInt("OverallRank");
    ffPositionRank = ffNode.getInt("PositionRank");
    salary = int(salaryNode[1]);
    println("OR: " + ffPositionRank);
  }
  
  void print() {
    println(displayName + " (" + position + ")");
    println(teamName + " (" + teamCallSign + ")");
    println("Overall Draft Rank: " + ffOverallRank);
    println("Position Draft Rank: " + ffPositionRank);
    println("Salary: " + salary);
  } 
}
