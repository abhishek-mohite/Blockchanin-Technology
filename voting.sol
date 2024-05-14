// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.16 <0.9.0;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        string election_id;
    }
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint public candidatesCount;
    string public candidate;

    constructor() {}

    event votedEvent(uint indexed _candidateId);

    function addCandidate(
        string memory _name,
        string memory _election_id
    ) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(
            candidatesCount,
            _name,
            0,
            _election_id
        );
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        emit votedEvent(_candidateId);
    }
}