// This is your test secret API key.
const stripe = Stripe("pk_test_51PQbobFAn4pX4Rdyg9becP6hPGTCMdN2gWdGns6xbm3pYF0vtkTtwdYVqPU37YgVA4YbJna09Q2Zhr2juzLJYvBg00NwmTpW3o");

initialize();

// Create a Checkout Session
async function initialize() {
  const fetchClientSecret = async () => {
    const response = await fetch("/create-checkout-session", {
      method: "POST",
    });
    const { clientSecret } = await response.json();
    return clientSecret;
  };

  const checkout = await stripe.initEmbeddedCheckout({
    fetchClientSecret,
  });

  // Mount Checkout
  checkout.mount('#checkout');
}