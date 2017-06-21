import io.gatling.core.Predef._
import io.gatling.http.Predef._

/**
  * Created by michal on 07/06/2017.
  */
class TransactionsJSONSimulation extends Simulation {
  val httpProtocol = http
    .baseURL("http://localhost:8080")
    .inferHtmlResources()
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:53.0) Gecko/20100101 Firefox/53.0")

  val headers_0 = Map("Upgrade-Insecure-Requests" -> "1")



  val scn = scenario("TransactionsJSONSimulation")
    .exec(http("account_1_json")
      .get("/account/1")
      .headers(headers_0))
    .pause(8)
    .exec(http("account_2_json")
      .get("/account/2")
      .headers(headers_0))
    .pause(27)
    .exec(http("accountList_json")
      .get("/accountList")
      .headers(headers_0))

  setUp(scn.inject(atOnceUsers(100))).protocols(httpProtocol)
}
