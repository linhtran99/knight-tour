This is a project by Linh Tran and Lam Lo for Logic Programming Course Spring 2019.

Introduction: Knight’s tour is a mathematical problem of finding the path of a knight. The goal is to find a path for a knight to visits every square on a chess board only once.

The purpose of this project is to create a knight's tour solver and a gameplay where user can control the knight's movements to solve the problem.

Notations and Representations:

The nxn chessboard is treated as a coordinate system with its axes go from 0 to n.

A knight’s position is presented as a coordinate pair X/Y.

The knight can move in a 2 by 1 or 1 by 2 square.

Example: If the current position is X/Y, then the knight can move to a new position X1/Y1 where X1 = X ± 1, Y1 = Y ± 2 or X1 = X ± 2, Y1 = Y ± 1.

The solution to a knight tour is presented as a sequence of knight’s positions, representing the movements of the knights.

Example: S = [1/1, 2/3, 1/5, 3/4, 5/5, 4/3, 5/1, …] is a move sequence starting from 1/1.

The chessboard display for the gameplay feature is presented as a map of binary, 1 for passed spots and 0 for untouched spots.

