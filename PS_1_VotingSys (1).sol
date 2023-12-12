// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    
    string[] candidates;   //here you have to put mutiple values
    mapping(string => uint256) votes;
    mapping(address => bool) hasVoted;
   
    function Add_Candidate_nm(string memory name_of_candidate) public {
        require(bytes(name_of_candidate).length > 0, "Candidate name cannot be empty");
        candidates.push(name_of_candidate);
        votes[name_of_candidate] = 0;
    }

    function vote(string memory candidateName ) public {
        require(bytes(candidateName).length > 0, "Candidate name cannot be empty");
        require(!hasVoted[msg.sender], "You have already voted");

        bool validCandidate = false;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i])) == keccak256(bytes(candidateName))) {
                validCandidate = true;
                break;
            }
        }
        
        require(validCandidate, "Invalid candidate");
        
        votes[candidateName]++;
        hasVoted[msg.sender] = true;
    }

    function list_of_candidates() public view returns (string[] memory) {
        return candidates;
    }
    
    function Winner() public view returns (string memory) {
        uint256 winningVoteCount = 0;
        string memory winningCandidate;
        
        for (uint256 i = 0; i < candidates.length; i++) {
            if (votes[candidates[i]] > winningVoteCount) {
                winningVoteCount = votes[candidates[i]];
                winningCandidate = candidates[i];
            }
        }
        return winningCandidate;
    }
}