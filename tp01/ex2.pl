pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(breitling).
team(redbull).
team(mediterranean).
team(cobra).
team(matador).

/* the 1st argument is a pilot on the 2nd argument team */
pilotTeam(lamb, breitling).
pilotTeam(besenyei, redbull).
pilotTeam(chambliss, redbull).
pilotTeam(maclean, mediterranean).
pilotTeam(mangold, cobra).
pilotTeam(jones, matador).
pilotTeam(bonhomme, matador).

plane(mx2).
plane(edge540).

pilotPlane(lamb, mx2).
pilotPlane(besenyei, edge540).
pilotPlane(chambliss, edge540).
pilotPlane(maclean, edge540).
pilotPlane(mangold, edge540).
pilotPlane(jones, edge540).
pilotPlane(bonhomme, edge540).

circuit(porto).
circuit(budapest).
circuit(istambul).


pilotWin(jones, porto).
pilotWin(mangold, budapest).
pilotWin(mangold, istambul).

circuitGates(porto, 5).
circuitGates(budapest, 6).
circuitGates(istambul, 9).


/*  X - team name
    Y - circuit name  */
teamWin(X, Y) :- won(Z, Y), belongs(Z, X), pilot(Z).