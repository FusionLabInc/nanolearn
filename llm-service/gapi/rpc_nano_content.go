package gapi

import (
	"fmt"
	"io"
	"path/filepath"

	"github.com/FusionLabInc/nanolearn/llm-service/pb"
	"github.com/FusionLabInc/nanolearn/llm-service/repository"
	"github.com/FusionLabInc/nanolearn/llm-service/utils/file"
	"github.com/FusionLabInc/nanolearn/llm-service/utils/methods"
)

const (
	uploadPath = "users_content/"
)

func (s *Server) NanoContent(stream pb.LlmService_NanoContentServer) error {

	file := file.NewFile()
	var fileSize uint32
	fileSize = 0
	var userId string
	defer func() {
		if err := file.OutputFile.Close(); err != nil {
			fmt.Println(err.Error())
		}
	}()
	for {
		req, err := stream.Recv()
		if file.FilePath == "" {
			file.SetFile(req.GetFileName(), uploadPath)
			userId = req.GetUserId()
		}
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println(err.Error())
			return err
		}
		chunk := req.GetChunk()

		fileSize += uint32(len(chunk))
		fmt.Printf("received a chunk with size: %d", fileSize)
		if err := file.Write(chunk); err != nil {
			fmt.Println(err.Error())
			return err
		}
	}

	fileName := filepath.Base(file.FilePath)

	contentId := methods.Base64Encode(fileName)

	// content := pdf_reader.ReadPdf(file.FilePath)

	content := `Crypto Solutions Suite
This document serves as the Product Requirement Document (PRD) for the
development and implementation of a comprehensive Crypto Solutions Suite
platform. In an era of increased globalization and interconnected digital
economies, the need for a sophisticated cryptocurrency solution that transcends
borders is paramount.
The purpose of the Crypto Solutions Suite platform is to offer a suite of robust
financial products and services that seamlessly facilitate international
cryptocurrency transactions, enhance cross-border trade, and provide clients with
a secure and efficient banking experience on a global scale. The platform will
leverage advanced blockchain technologies to deliver innovative solutions,
ensuring the ease of managing digital assets across diverse currencies and
regulatory environments.
Use Cases
These are the following use cases that companies can develop on top of the
Crypto Solutions Suite platform:
1. Crypto Payroll Services: Companies can offer payroll solutions that allow
businesses to pay their employees in cryptocurrencies, providing a seamless
way to manage international payroll with reduced fees and faster transactions.
2.DeFi Lending and Borrowing Platforms: Companies can develop
decentralized finance (DeFi) platforms that enable users to lend and borrow
cryptocurrencies, offering competitive interest rates and decentralized
governance.
3.Crypto Escrow Services: Companies can create secure escrow services for
transactions involving large sums of cryptocurrency, ensuring both parties
f
ulfill their obligations before the f
unds are released.
4.Tokenized Asset Trading: Companies can offer platforms for trading
tokenized versions of real-world assets, such as real estate or commodities,
providing liquidity and access to a broader range of investors.
5.Blockchain-Based Supply Chain Management: Companies can develop
blockchain solutions for tracking and verifying the provenance and movement
of goods through the supply chain, ensuring transparency and reducing fraud.
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 1/11
6.Crypto Staking Services: Companies can offer staking platforms where users
can stake their cryptocurrencies to earn rewards, participating in network
validation and governance.
7. NFT Marketplaces: Companies can create marketplaces for non-f
ungible
tokens (NFTs), enabling users to buy, sell, and trade unique digital assets,
such as artwork, collectibles, and virtual real estate.
8.Crypto-Backed Loans: Companies can provide loan services where users can
use their cryptocurrency holdings as collateral, accessing f
unds without
needing to sell their digital assets.
9.Cross-Border Microtransactions: Companies can develop platforms that
facilitate microtransactions across borders, enabling small payments for
services or content without high fees, ideal for content creators and small
businesses.
10.Crypto Donation Platforms: Companies can create platforms for charitable
donations using cryptocurrencies, ensuring transparency and traceability of
f
unds, and reaching a global audience of donors.
WHAT HAS BEEN DONE SO FAR
1. Initial core for creating crypto wallets has been created with connection to
different providers. i.e Tatum for CELO, Coinremitta for BTC, USDT, USDC e.t.c
2.Initial core frame works for on-ramp and off-ramp
3.Card manager integration built on-top of crypto infrastructure to allow
f
unding
in CELO (USDT, USDC incoming)
WHAT NEEDS TO BE DONE.
1. Migration of
base infra for wallets such as BTC, ETH, USDC and USDT to tatum
and testing of features.
2. Card manager integration built on-top of crypto infrastructure to allow
f
unding
in (USDT, USDC)
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 2/11
NEXT RELEASE FUNCTIONALITIES:
1. Migrate BTC, ETH, USDC and USDT to TATU
M
2.Test of the whole core infrastructure.
3.Live docs on a domain
4.Frontend integration V1.
5.Card manager integration built on-top of crypto infrastructure to allow
f
unding
in (USDT, USDC)
6.Billing for Crypto service
TECHNICAL
REQUIREMENTS
The following entities will be created to facilitate this product.
1. Cardholder
2.Wallet
3.Payin
4.Payout
5.Transaction
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 3/11
The api requirements for each entities is shared below:
Cardholder
• Api To Create a Cardholder
• Api To Fetch a Cardholder (with the cardholders current tier)
◦ Tier 1 scopes - ngn_account, usd_virtual_card, ngn_virtual_card
◦ Tier 2 scopes - usd_account, usd_physiscal_card, ngn_physical_card
• Api To Update a Cardholder Tier
Edge Cases:
1. For our current usecase with our current provider, we are tying multiple
cards to a cardholder.
2.We need to be able to create master_cardholders that will host multiple
cards on them.
3.We need to make sure that what ever implementation we do, we don’t run
into a scenario where we have less accounts to cards ratio.
Wallet
• API to create a wallet address - BTC, ETH, USDTERC20, USDTRC20, CUSD
• API to validate wallet address
• API to get wallet balance
Edge Cases:
PAYIN (CARD / ACCOUNTS)
• API to get PAYIN rate.
{
“wallet_id”: Optional[str], if you have a wallet id, pass the wallet id, else pass
a wallet addres,
“type”: CARD O
R ACCOUNT
“from_currency”: USD, NGN (Support Currentcy), e.t.c
“to_currency”: Optional[str] - BTC, USDTERC20, CELO, USDTRC20
} — 3
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 4/11
• API TO CREATE A PAYIN REQUEST
{
“wallet_id”: Optional[str], if you have a wallet id, pass the wallet id, else pass a
wallet addres,
“type”: CARD O
R ACCOUNT
“from_currency”: USD, NGN (Support Currentcy), e.t.c
“to_currency”: Optional[str] - BTC, USDTERC20, CELO, USDTRC20,
”card_details” : if card
{
"pan": "506119",
"pin": "1235",
"billed_amount":"",
"billing_zip": "",
"billing_city": "",
"billing_address": "",
"billing_state": "",
"billing_country": "",
"card_token": ""
}
}
Response - {
“payin_id”: “ddd”
“from_currency”: NGN,
“to_currency”: “CELO”
“type”: ACCOUNT
“rate”: 0.,
“expiry” 1 minutes,
“account_number”
}
• API TO EXECUTE A PAYIN REQUEST
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 5/11
{
“payin_id” == “”.
}
Edge Cases:
1. Validate that payin requests haven’t expired before processing them.
PAYOUT (CARD / ACCOUNTS)
• API to get PAYOUT rate.
{
“wallet_id”: Optional[str], if you have a wallet id, pass the wallet id, else pass
a wallet addres,
“type”: CARD O
R ACCOUNT
“from_currency”: BTC, USDTERC20, CELO, USDTRC20
“to_currency”: Optional[str] -USD, NGN (Support Currentcy), e.t.c
} — {
“from_currency”: NGN,
“to_currency”: “CELO”
“type”: ACCOUNT
“rate”: 0.45
}
• API TO CREATE A PAYOUT REQUEST
{
“wallet_id”: Optional[str], if you have a wallet id, pass the wallet id, else pass a
wallet addres,
“type”: CARD O
R ACCOUNT
“from_currency”: USD, NGN (Support Currentcy), e.t.c
“to_currency”: Optional[str] - BTC, USDTERC20, CELO, USDTRC20,
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 6/11
”card_details” : if card
{
"pan": "506119",
"pin": "1235",
"billed_amount":"",
"billing_zip": "",
"billing_city": "",
"billing_address": "",
"billing_state": "",
"billing_country": "",
}
}
Response - Response - {
“payin_id”: “ddd”
“from_currency”: NGN,
“to_currency”: “CELO”
“type”: ACCOUNT
“rate”: 0.,
“expiry” 1 minutes,
“token_link”/”scanner”
}
• API TO EXECUTE A PAYOUT REQUEST
{
“payin_id”,
}
Transaction
• Api To Fetch a Transaction
• Api To Fetch all wallet transaction via wallet id
Edge Cases:
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 7/11
CO
MPANY WALLETS
1. /company/wallets
BTC, ETH, USDTERC20, USDTRC20, CUSD
admin node
crypto_wallets - []
1. /company/wallets/validate
- phoennumber - take it.
- password - md5 (hashed password)
•
verify otp - choicee
specify transient or not
2.Create payment link per wallet.
Other Technical Requirements
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 8/11
1. Webhooks
These webhooks will be required to facilitate this product
• account_credit_event.successf
ul
• transfer_event.successf
ul
• transfer_event.failed
• business_verification.successf
ul
• business_verification.failed
• business_tier_update.successf
ul
• business_tier_update.failed
• cardholder_tier_update.successf
ul
• cardholder_tier_update.failed
2. Billing
Based on the pricing strategy , the billing service will be updated to support
billing.
Issuing Fee -
Transaction Fee -
3. Encryption/3D Security
4.Accounting
•
Loopholes
5.Admin Interface
•Revamp of Admin Interface to Crypto Product Lines Natively
6.Documentation
7. Testing
8.Deployment(CI/CD)
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 9/11
9.Monitoring
RELEASE PHASES
Phase 1 -
Phase 2 -
Requirements
BRIDGECARD ON-RAMP/OFF-RAMP SERVICE
Problem: Many companies can create crypto wallets and to P2P but they can’t do
onramp/offramp. (onramp - fiat to crypto, offramp - crypto - fiat)
ON-RAMP
Allow a person to either send money to a bank account or put in their card details
and we charge the card and send them crypto to a wallet address.
1. API to create payment link - create this payment link, encode with company’s
secret key.
2.Web
view to process link will decode link with company’s secret key.
o/{encoded_data}
crypto.bridgecard.c
encoded_data:
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 10/11
8/8/24, 1:01 PM Crypto Solutions Suite
https://icy-steam-d24.notion.site/Crypto-Solutions-Suite-402695f203e0424bb834e916230611b1 11/11
`

	// mainContent := s.Repository.Content.GenerateContentSummary(stream.Context(), content, *s.Env)

	// fmt.Println(mainContent)

	glassaryContent := s.Repository.Content.GenerateContentGlossary(stream.Context(), content, *s.Env)

	fmt.Println(glassaryContent)

	// if mainContent != nil && glassaryContent != nil {

	// 	for index, section := range mainContent.MainSection {

	// 		sectionId := methods.GenerateRandomID()

	// 		fmt.Println("Section Title:", section.SectionTitle)
	// 		fmt.Println("Summary:", section.Summary)

	// 		subSectionContent := s.Repository.Content.GenerateDeepContentExplanation(stream.Context(), content, section.SectionTitle, section.Summary, *s.Env)

	// 		fmt.Println(subSectionContent)

	// 		if subSectionContent != nil {

	// 			s.Repository.Content.AddContentSummary(stream.Context(), contentId, userId, sectionId, index, subSectionContent)
	// 		}

	// 	}

	// }

	s.Repository.Content.AddContentGlossary(stream.Context(), contentId, glassaryContent)

	user := s.Repository.User.Get(stream.Context(), userId)

	s.Repository.User.Update(stream.Context(), userId, repository.User{
		ID:        user.ID,
		Username:  user.Username,
		CreatedAt: user.CreatedAt,
		Contents: []repository.Content{
			{
				ID:       contentId,
				FileName: fileName,
				Size:     fileSize,
			},
		},
	})

	fmt.Printf("saved file: %s, size: %d", fileName, fileSize)
	return stream.SendAndClose(&pb.NanoContentResponse{FileName: fileName, Size: fileSize})

}
