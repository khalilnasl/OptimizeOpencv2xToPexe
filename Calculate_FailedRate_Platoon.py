#!/usr/bin/env python3

import pandas as pd

def main():
    # Placeholder for results
    results = []

    # Read the csv file
    for methods in ['P', 'R']:
        for car_numbers in [9,12,15,18,21,24,27,30]:
            for repetition in [0,1,2,3,4,5,6,7,8,9]:
                TB_R = pd.read_csv("/MY_PATH/{}_{}_{}.csv".format(methods, car_numbers, repetition), sep="\t")

                # Filter for specific node numbers
                TB_R['node_num'] = TB_R['node'].str.extract(r'Highway.node\[(\d+)\]').astype(float)
                TB_R_filtered_nodes = TB_R[TB_R['node_num'] < 4]

                # Filter for specific sender IDs
                senderIDs = [2097, 2098, 2099, 2100]
                TB_R_filtered = TB_R_filtered_nodes[TB_R_filtered_nodes['senderID:vector'].isin(senderIDs)]

                # Initialize aggregates
                total_sent = 0
                total_unsensed = 0
                total_decoded = 0

                # Loop through all Highway.node nodes
                for node in TB_R_filtered['node'].unique():
                    # sent
                    sent = TB_R[TB_R.node == 'Highway.node[0].lteNic.phy']["tbSent:vector"].sum() * 3
                    # Unsensed
                    unsensed = TB_R_filtered[TB_R_filtered.node == node]["sciUnsensed:vector"].sum()
                    # decoded
                    decoded = TB_R_filtered[TB_R_filtered.node == node]["tbDecoded:vector"].sum()

                    # Aggregate
                    total_sent += sent
                    total_unsensed += unsensed
                    total_decoded += decoded

                successSent = (total_sent - total_unsensed)
                unsuccessSent = successSent - total_decoded
                if successSent != 0:  # To avoid division by zero
                    failedRate = unsuccessSent / successSent
                    results.append("['{}', 'car{}', {},{}],".format(methods, car_numbers, repetition, failedRate))

    # Print results
    for res in results:
        print(res)

if __name__ == "__main__":
    main()
